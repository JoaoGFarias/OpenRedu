#Observations
#The Login button referes to the button labeled as "Enviar" when the system language
#is set to Pt-Br


Feature:
  As a user
  I want to log into the OpenRedu
  So that I interact securely with the system

  #Sucessful login
    #Login via username and e-mail
    @login @sc01 @tobeautomated
    Scenario: Login via username/password clicking on the login button
    Given I am at the Login page
    When  I fill the username field with "<username_login>" and the password field with "<password>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username>"
    #
    @login @sc02 @tobeautomated
    Scenario: Login via email/password clicking on the login button
    Given I am at the Login page
    When  I fill the username field with "<email>" and the password field with "<password>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username>"

    @login @sc03 @tobeautomated
    Scenario: Login via email/password clicking on the Enter keyboard button
    Given I am at the Login page
    When  I fill the username field with "<email>" and the password field with "<password>"
    And   I press on the "Enter" keyboard button
    Then  I should be on the Home page for user "<username>"

    #Uppercase on username and password

    @login @sc04 @tobeautomated
    Scenario: Login via username/password with uppercase on username
    Given I am at the Login page
    When  I fill the username field with "<uppercase_username>" and the password field with "<password>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username>"

    @login @sc05 @tobeautomated
    Scenario: Login via username/password with uppercase on password
    Given I am at the Login page
    When  I fill the username field with "<username>" and the password field with "<uppercase_password>"
    And   I click on the "Login" button
    Then  I should see the invalid password error message

    @login @sc06 @tobeautomated
    Scenario: Login via username/password after having logout
    Given I am at the Login page
    When  I fill the username field with "<username1>" and the password field with "<password1>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username>"
    When  I logout from the system
    Then  I should be on the Login page
    When  I fill the username field with "<username2>" and the password field with "<password2>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username>"

    @login @sc07 @tobeautomated
    Scenario: Login via username/password after having log in and pressed the backward button
    Given I am at the Login page
    When  I fill the username field with "<username1>" and the password field with "<password1>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username1>"
    When  I press on the "Backward" browser button
    Then  I am at the Login page
    When  I fill the username field with "<username2>" and the password field with "<password2>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username2>"

    @login @sc08 @manual
    Scenario: Login via username/password after having log in and pressed the backward button
    Given I am at the Login page
    When  I fill the username field with "<username1>" and the password field with "<password1>"
    And   I click on the "Login" button
    Then  I should be on the Home page for user "<username1>"
    When  I open a new tab on the browser
    Then  I should be on the Home page for user "<username1>"
    When  I fill the username field with "<username2>" and the password field with "<password2>"
    Then  I should be on the Home page for user "<username2>"
    When  I reload the first tab
    Then  I should be on the Home page for user "<username2>"


  #Unsuccessful login

  @login @sc09 @tobeautomated
  Scenario: Faield Login via username/password due invalid password
  Given I am at the Login page
  When  I fill the username field with "<username>" and the password field with "<invalid_password>"
  And   I click on the "Login" button
  Then  I should see the invalid password error message

  @login @sc10 @tobeautomated
  Scenario: Faield Login via username/password due invalid username
  Given I am at the Login page
  When  I fill the username field with "<invalid_username>" and the password field with "<password>"
  And   I click on the "Login" button
  Then  I should see the invalid username error message

  @login @sc11 @tobeautomated
  Scenario: Faield Login via username/password due invalid username (without @)
  Given I am at the Login page
  When  I fill the username field with "<username_without_at>" and the password field with "<invalid_password>"
  And   I click on the "Login" button
  Then  I should see the invalid username error message

  @login @sc12 @tobeautomated
  Scenario: Faield Login via username/password due empty password
  Given I am at the Login page
  When  I fill the username field with "<username>" and the password field with "<empty_password>"
  And   I click on the "Login" button
  Then  I should see the empty password error message

  @login @sc13 @tobeautomated
  Scenario: Faield Login via username/password due both empty username and empty password
  Given I am at the Login page
  When  I fill the username field with "<empty_username>" and the password field with "<empty_password>"
  And   I click on the "Login" button
  Then  I should see the empty username error message

  #Layout

  @login @sc14 @manual
  Scenario: Check login layout responsiveness
  Given I am at the Login page
  And   My browser is on fullscreen
  Then  I verify that the Username and Password fields are aligment
  And   I verify that the Login button is right indented
  When  I resize my browser
  Then  I verify that the Username and Password fields are aligment
  And   I verify that the Login button is right indented