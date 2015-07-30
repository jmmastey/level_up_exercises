Given(/^I do not have an account$/) do
  expect(User.exists?(email: USER[:email])).to be(false)
end

Given(/^I have an account$/) do
  sign_up(USER[:username], USER[:email], USER[:password])
  visit(destroy_user_session_path)
end

Given(/^I visit the sign up page$/) do
  visit(new_user_registration_path)
end

When(/^I enter my username$/) do
  fill_in(:user_username, with: USER[:username])
end

When(/^I enter my password$/) do
  fill_in(:user_password, with: USER[:password])
end

When(/^I enter my confirmation password$/) do
  fill_in(:user_password_confirmation, with: USER[:password])
end

When(/^I enter my email address$/) do
  fill_in(:user_email, with: USER[:email])
end

When(/^click sign up$/) do
  click_button('Sign Up')
end

Then(/^I expect to view my profile page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid username, (\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I expect to have a username error$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not view my profile page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid username, asdf$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid username, _@\#\$$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid password, (\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should expect to have a password error$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid password, tooshort$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid password, NoNumbers$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid password, Ask(\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid password, !\$%@\#\$\#@$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid email, invalid\.com$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should expect to have an email error$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid email, invalid@com$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid email, missing@extension$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid email, double@at@sign\.com$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an invalid email, just_some_text_(\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I enter a username that is taken$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should expect to have a username taken error$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter an email that is taken$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should expect to have an email taken error$/) do
  pending # express the regexp above with the code you wish you had
end
