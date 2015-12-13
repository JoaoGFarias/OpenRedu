class Login < SitePrism::Page
  set_url "/"

  #Sections
  section :header, HeaderNotLogged, "div.header-not-logged-in"

  def press_key_element
    header.press_key_element
  end

end
