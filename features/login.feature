
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
    And   I click on the Login button
    Then  I should be on the Home page for user "<username>"
    #
    @login @sc02 @tobeautomated
    Scenario: Login via email/password clicking on the login button
    Given I am at the Login page
    When  I fill the username field with "<email>" and the password field with "<password>"
    And   I click on the Login button
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
    And   I click on the Login button
    Then  I should be on the Home page for user "<username>"

    @login @sc05 @tobeautomated
    Scenario: Login via username/password with uppercase on password
    Given I am at the Login page
    When  I fill the username field with "<username>" and the password field with "<uppercase_password>"
    And   I click on the Login button
    Then  I should see the invalid password error message

    @login @sc06 @tobeautomated @semi-manual
    Scenario: Clean the cookies after login
    Given I am at the Login page
    When  I fill the username field with "<username_login>" and the password field with "<password>"
    And   I click on the Login button
    Then  I should be on the Home page for user "<username>"
    When  I clean the browser's cookies
    And   I reload the page
    Then  I should be on the Login page
    And   I should see the page access error message

    @login @sc01 @tobeautomated
    Scenario: Login via username/password after having logout
    Given I am at the Login page
    When  I fill the username field with "<username1>" and the password field with "<password>"
    And   I click on the Login button
    Then  I should be on the Home page for user "<username>"
    When  I logout from the system
    Then  I should be on the Login page
    When  I fill the username field with "<username2>" and the password field with "<password>"
    And   I click on the Login button
    Then  I should be on the Home page for user "<username>"

  #Unsuccessful login

  @login @sc06 @tobeautomated
  Scenario: Faield Login via username/password due invalid password
  Given I am at the Login page
  When  I fill the username field with "<username>" and the password field with "<invalid_password>"
  And   I click on the Login button
  Then  I should see the invalid password error message

  @login @sc07 @tobeautomated
  Scenario: Faield Login via username/password due invalid username
  Given I am at the Login page
  When  I fill the username field with "<invalid_username>" and the password field with "<password>"
  And   I click on the Login button
  Then  I should see the invalid username error message

  @login @sc08 @tobeautomated
  Scenario: Faield Login via username/password due invalid username (without @)
  Given I am at the Login page
  When  I fill the username field with "<username_without_at>" and the password field with "<invalid_password>"
  And   I click on the Login button
  Then  I should see the invalid username error message

  @login @sc09 @tobeautomated
  Scenario: Faield Login via username/password due empty password
  Given I am at the Login page
  When  I fill the username field with "<username>" and the password field with "<empty_password>"
  And   I click on the Login button
  Then  I should see the empty password error message

  @login @sc10 @tobeautomated
  Scenario: Faield Login via username/password due both empty username and empty password
  Given I am at the Login page
  When  I fill the username field with "<empty_username>" and the password field with "<empty_password>"
  And   I click on the Login button
  Then  I should see the empty username error message




  #Layout
