class HeaderNotLogged < SitePrism::Section

  #Elements
  element :button_sign_in           , "button#button-sign-in"
  element :username_login           , "input#user_session_login"
  element :password_login           , "input#user_session_password"
  element :button_submit_login      , "div.header-sign-in-form-submit input.pull-right"
  element :opened_login_box         , "div.button-group.dropdown.pull-right.open"
  element :invalid_password_message , "form#form-sign-in div:nth-child(3) ul.errors_on_field"

  def press_key_element
    password_login
  end

  def log_with_username(username, password)

    if(not login_box_opened?) then
      button_sign_in.click
    end

    username_login.set(username)
    password_login.set(password)
    password_login.click
  end

  def login_box_opened?
    has_opened_login_box? && opened_login_box.visible?
  end

  def invalid_password_display?
    wait_until_invalid_password_message_visible(2)
    invalid_password_message.visible?
  end

end
