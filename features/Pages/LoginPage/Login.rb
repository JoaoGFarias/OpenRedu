class Login < SitePrism::Page
  set_url "/"

  #Sections
  section :header, HeaderNotLogged, "div.header-not-logged-in"

  #Elements
  element :welcome_message, "h2.landing-welcome-title"

  def press_key_element
    header.press_key_element
  end

  def load
    super()
    self.wait_load
  end

  def wait_load
    HoldOn.until(timeout: 30, interval: 0.5, message: "The Login Page did not load after 30 seconds") do
      has_welcome_message? && welcome_message.visible?
    end
  end

end
