class Home < SitePrism::Page
  set_url "/pessoas/{/username}/home"

  #Elements
  element :welcome_message , "span.home-hello-user"

  def load(username)
    self.wait_load
    super(username: username[:username])
  end

  def wait_load
    HoldOn.until(timeout: 30, interval: 0.5, message: "Waiting for Home Page") do
      has_welcome_message? && welcome_message.visible?
    end
  end

end