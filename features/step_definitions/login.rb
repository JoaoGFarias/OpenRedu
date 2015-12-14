When(/^I fill the username field with "(.*?)" and the password field with "(.*?)"$/) do |username, password|
  @page.header.button_sign_in.click
  @page.header.log_with_username(username, password)
end

When(/^I click on the Submit button$/) do
  @page.header.button_submit_login.click
end

When(/^I logout from the system$/) do
  @page.header.logout
end

Then(/^I should see the invalid password error message$/) do
  @page.header.invalid_password_display?.should be_true
end
