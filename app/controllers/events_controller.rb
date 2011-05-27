class EventsController < BaseController
  load_and_authorize_resource :environment, :find_by => :path
  load_and_authorize_resource :space
  load_and_authorize_resource :event, :through => [:space, :environment]

  before_filter :find_environment_course_and_space

  cache_sweeper :event_sweeper, :only => [:create, :update, :destroy]
  after_filter :create_activity, :only => [:create]

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "Você não tem acesso a essa página"
    redirect_to space_path(@space)
  end

  #These two methods make it easy to use helpers in the controller.
  #This could be put in application_controller.rb if we want to use
  #helpers in many controllers
  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::SanitizeHelper
    extend ActionView::Helpers::SanitizeHelper::ClassMethods
  end

  def show
    @eventable = find_eventable
    respond_to do |format|
      format.html
    end
  end

  def index
    @eventable = find_eventable
    @events = @eventable.events.approved.upcoming.includes(:owner).
      paginate(:page => params[:page], :order => 'start_time',
               :per_page => Redu::Application.config.items_per_page)

    @list_title = "Eventos Futuros"

    respond_to do |format|
      format.html
      format.js { render_endless 'events/item', @events, '#events_list > ul' }
    end
  end

  def past
    @eventable = find_eventable
    @events = @eventable.approved.past.includes(:owner).
      paginate(:page => params[:page], :order => 'start_time DESC',
               :per_page => Redu::Application.config.items_per_page)

    @list_title = "Eventos Passados"

    respond_to do |format|
      format.html { render :index }
    end
  end

  def new
    @eventable = find_eventable

    respond_to do |format|
      format.html
    end
  end

  def edit
    @eventable = find_eventable

    respond_to do |format|
      format.html
    end
 end

  def create
    @event = Event.new(params[:event])

    @event.owner = current_user
    @event.eventable = find_eventable

    respond_to do |format|
      if @event.save

        if @event.owner.can_manage? @event
          @event.approve!
          flash[:notice] = "O evento foi criado e divulgado."
        else
          flash[:notice] = "O evento foi criado e será divulgado assim que for aprovado pelo moderador."
        end

        format.html { redirect_to polymorphic_path([@event.eventable, @event]) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        @eventable = @event.eventable
        format.html do
          render :new
        end
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'O evento foi editado.'
        format.html { redirect_to polymorphic_path([@event.eventable, @event]) }
        format.xml { render :xml => @event, :status => :created, :location => @event }
      else
        @eventable = find_eventable
        format.html { render :edit }
        format.xml { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      flash[:notice] = 'O evento foi excluído.'
      format.html { redirect_to polymorphic_path(@event.eventable) }
    end
  end

  def vote
    @event = Event.find(params[:id])
    current_user.vote(@event, params[:like])

    respond_to do |format|
      format.js { render :template => 'shared/like', :locals => {:votes_for => @event.votes_for().to_s} }
    end
  end

  def notify
    event = Event.find(params[:id])
    notification_time = event.start_time - params[:days].to_i.days
    Delayed::Job.enqueue(EventMailingJob.new(current_user, event), nil, notification_time)
    #TODO Verificar se a prioridade nil (zero) pode trazer problemas
    flash[:notice] = "Sua notificação foi agendada."

    redirect_to polymorphic_path([event.eventable, event])
  end

  protected

  def find_eventable
    Space.find(params[:space_id]) if params[:space_id]
  end

  def find_environment_course_and_space
    if params[:space_id]
      @space = Space.find(params[:space_id])
      @course = @space.course
      @environment = @course.environment
    end
  end
end
