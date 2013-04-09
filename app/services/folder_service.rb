class FolderService < StoredContentService
  def initialize(options)
    super options.merge(:model_class => Folder)
  end

  # Destroy Folder e garante a autorização (:manage).
  #
  # Retorna a instância do Folder.
  # Lança CanCan::AccessDenied caso não haja autorização
  def destroy(folder)
    authorize!(folder)
    folder.destroy
    refresh! #só atualiza quotas na destruição
    folder
  end

  protected

  def infered_quota
    if @model && @model.space
      @model.space.course.quota || @model.space.course.environment.quota
    end
  end

  def authorize!(folder)
    ability.authorize!(:manage, folder)
  end

  def refresh!
    quota.refresh!
  end
end
