class Header_Not_Logged < SitePrism::Section

  #Elements
  element :button_sign_in     , "button#button-sign-in"
  element :username_login     , "input#user_session_login"
  element :password_login     , "input#user_session_password"
  element :button_submit_login, "div.header-sign-in-form-submit input.pull-right"

end
