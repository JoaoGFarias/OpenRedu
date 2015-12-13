class HeaderNotLogged < SitePrism::Section

  #Elements
  element :button_sign_in     , "button#button-sign-in"
  element :username_login     , "input#user_session_login"
  element :password_login     , "input#user_session_password"
  element :button_submit_login, "div.header-sign-in-form-submit input.pull-right"
  element :opened_login_box   , "div.button-group.dropdown.pull-right.open"

  def press_key_element
    password_login
  end

  def log_with_username(username, password)

    if(not is_login_box_opened) then
      button_sign_in.click
    end

    username_login.set(username)
    password_login.set(password)
    password_login.click
  end

  def is_login_box_opened
    return has_opened_login_box? && opened_login_box.visible?
  end
end
