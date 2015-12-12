Given(/^I am at the "(.*?)" page$/) do |page_name|

  @page = PagesSupport.get_page(page_name)
  @page.load
  expect(@page).to be_displayed
end

When(/^I fill the username field with "(.*?)" and the password field with "(.*?)"$/) do |username, password|
  @page.header.button_sign_in.click
  @page.header.log_with_username(username, password)
end

When(/^I click on the Submit button$/) do
  @page.header.button_submit_login.click
end

Then(/^I should be on the Home page for user "(.*?)"$/) do |username|
  @page = PagesSupport.get_page("Home")
  @page.load(username: username)
  expect(@page).to be_displayed(username: username)
end
