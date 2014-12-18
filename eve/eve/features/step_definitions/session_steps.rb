def create_user(email, password)
  FactoryGirl.create(:user,
                     email: email,
                     password: password,
                     password_confirmation: password)
end

def sign_in(email, password)
  visit "/users/sign_in"
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Sign In"
end

Given(/^I am on the registration page$/) do
  visit "/users/sign_up"
end

Given(/^the following users exist:$/) do |user_table|
  user_table.hashes.each do |user|
    create_user(user[:email], user[:password])
  end
end

Given(/^I am on the login screen$/) do
  visit('/users/sign_in')
end

Given(/^I am signed in$/) do
  user = create_user("cukeuser@example.com", "testtest")
  sign_in(user.email, user.password)
end

When(/^I visit the registration page$/) do
  visit "/users/sign_up"
end

When(/^I enter the email "([^"]*)"$/) do |email|
  fill_in("user_email", with: email)
end

When(/^I enter the password (confirmation )?"([^"]*)"$/) do |confirmation, password|
  field = "user_password"
  field << "_confirmation" if confirmation

  fill_in(field, with: password)
end
