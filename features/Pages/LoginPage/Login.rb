class Login < SitePrism::Page
  set_url "/"

  #Sections
  section :header, HeaderNotLogged, "div.header-not-logged-in"

end
