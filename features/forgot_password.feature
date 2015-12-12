Feature:
  As a user
  I want to re-define my forgotten password
  So that I can use the OpenRedu even when I forgot my password

  @logout @sc01 @sanity @tobeautomated @semi-manual
  Scenario: Send request for password redefinition
  Given I access the "Retrive Password" page
  When  I fill the "email" field with "<users_email>"
  Then  I should have receive an e-mail request password redefinition
