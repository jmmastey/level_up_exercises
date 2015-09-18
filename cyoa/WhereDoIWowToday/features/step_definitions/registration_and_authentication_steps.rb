VALID_EMAIL = "name@example.com"
VALID_PASSWORD = "asdf1234"
EMAIL = '(?:| email "([^"]*)")'
PASSWORD = '(?:| password "([^"]*)")'
CONFIRM = '(?:| confirmation "([^"]*)")'

Given(/^the account "([^"]*)" with#{PASSWORD} exists$/) do |name, pass|
  stub_request(:any, /us.api.battle.net/)
  visit path_to("registration")
  fill_in("user_email", with: name)
  fill_in("user_password", with: pass)
  fill_in("user_password_confirmation", with: pass)
  click_button("Sign up")
  click_link("Logout")
end

Given(/^the account "([^"]*)" does not exist$/) do |arg1|
  stub_request(:any, /us.api.battle.net/)
  visit '/'
end

Given(/^I am logged in as an admin$/) do
  stub_request(:any, /us.api.battle.net/)
  visit "/"
  admin = FactoryGirl.create(:admin, password: VALID_PASSWORD)
  click_link("Login")
  fill_in("user_email", with: admin.email)
  fill_in("user_password", with: VALID_PASSWORD)
  click_button("Log in")
end

Given(/^I am logged in as a normal user$/) do
  stub_request(:any, /us.api.battle.net/)
  visit "/"
  user = FactoryGirl.create(:user, password: VALID_PASSWORD)
  click_link("Login")
  fill_in("user_email", with: user.email)
  fill_in("user_password", with: VALID_PASSWORD)
  click_button("Log in")
end

When(/^I register with#{EMAIL},?#{PASSWORD},?#{CONFIRM}$/) do |name, pass, conf|
  fill_in("user_email", with: name || VALID_EMAIL)
  fill_in("user_password", with: pass || VALID_PASSWORD)
  fill_in("user_password_confirmation", with: conf || pass || VALID_PASSWORD)
  click_button("Sign up")
end

When(/^I login(?:| with#{EMAIL},?#{PASSWORD})$/) do |name, pass|
  click_link("Login")
  fill_in("user_email", with: name || VALID_EMAIL)
  fill_in("user_password", with: pass || VALID_PASSWORD)
  click_button("Log in")
end

When(/^I logout$/) do
  click_link("Logout")
end

Then(/^I should be signed up as "([^"]*)"$/) do |user|
  step "I should see \"signed up successfully\""
  step "I should see \"Logged in as #{user}\""
end

Then(/^I should be logged in as "([^"]*)"$/) do |user|
  step "I should see \"Logged in as #{user}\""
end

Then(/^I should not be logged in$/) do
  step "I should see \"Login\""
end
