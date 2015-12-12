#Observations
#The Login button referes to the button labeled as "Enviar" when the system language
#is set to Pt-Br

Feature:
  As a user
  I want to logout the OpenRedu
  So that I can securely end my session

  @logout @sc01 @sanity @tobeautomated
  Scenario: Logout from the system
  Given I am at the Login page
  When  I fill the username field with "<username_login>" and the password field with "<password>"
  And   I click on the "Login" button
  Then  I should be on the Home page for user "<username>"
  When  I logout from the system
  Then  I should be on the Login Page

  @logout @sc02 @sanity @tobeautomated @semi-manual
  Scenario: Clean the cookies after login
  Given I am at the Login page
  When  I fill the username field with "<username_login>" and the password field with "<password>"
  And   I click on the "Login" button
  Then  I should be on the Home page for user "<username>"
  When  I clean the browser's cookies
  And   I reload the page
  Then  I should be on the Login page
  And   I should see the page access error message
