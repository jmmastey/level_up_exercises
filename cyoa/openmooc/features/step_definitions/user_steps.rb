def unregistered_user
  @session_user ||= FactoryGirl.build(:unregistered_user)
end

def registered_user
  @session_user ||= FactoryGirl.create(:registered_user)
end

def sign_up_inputs(user)
  { Email: user.email,
    Password: user.password,
    'Password confirmation' => user.password }
end

def sign_in_inputs(user)
  { Email: user.email,
    Password: user.password }
end

def change_password_inputs(user, new_password)
  { 'Current password' => user.password,
    Password: new_password,
    'Password confirmation' => new_password }
end

def reset_password_button_value
  'Reset my password'
end

###### GIVEN ######

Given(/^I am on the change password page$/) do
  visit(edit_user_registration_path)
end

Given(/^I am on the sign up page$/) do
  visit(new_user_registration_path)
end

Given(/^I am on the reset password page$/) do
  visit(new_user_password_path)
end

Given(/^I am on the sign in page$/) do
  visit(new_user_session_path)
end

###### WHEN ######

When(/^I submit a registered email$/) do
  submit_form(reset_password_button_value, Email: registered_user.email)
end

When(/^I enter existing email sign up credentials$/) do
  submit_form('Sign up', sign_up_inputs(registered_user))
end

When(/^I visit the change password page$/) do
  visit(edit_user_password_path)
end

When(/^I change my password$/) do
  new_password = 'newpassword'
  submit_form('Update', change_password_inputs(@session_user, new_password))
  @session_user.password = new_password
end

When(/^I submit a non user email$/) do
  submit_form(reset_password_button_value, Email: unregistered_user.email)
end

When(/^I enter valid sign up credentials$/) do
  submit_form('Sign up', sign_up_inputs(unregistered_user))
end

When(/^I enter bad email sign up credentials$/) do
  user = unregistered_user
  user.email = 'real%3&@bad$#@.com'
  submit_form('Sign up', sign_up_inputs(user))
end

When(/^I enter bad password sign up credentials$/) do
  user = unregistered_user
  user.password = '1234'
  submit_form('Sign up', sign_up_inputs(user))
end

When(/^I leave the site$/) do
  visit('http://www.google.com')
end

When(/^I sign out$/) do
  click_link('Log out')
end

When(/^I click on reset password$/) do
  click_link('Forgot your password?')
end

When(/^I enter valid sign in credentials$/) do
  submit_form('Log in', sign_in_inputs(registered_user))
end

When(/^I enter invalid sign in credentials$/) do
  submit_form('Log in', sign_in_inputs(unregistered_user))
end

When(/^I visit the sign in page$/) do
  visit(new_user_session_path)
end

###### THEN ######

Then(/^I should be on the sign in page$/) do
  expect(current_path).to eq(new_user_session_path)
end

Then(/^I should not be signed in$/) do
  expect(page).to have_selector(:link_or_button, 'Log in')
end

Then(/^I should be signed in$/) do
  expect(page).to have_selector(:link_or_button, 'Log out')
end

Then(/^I should be on the reset password page$/) do
  expect(current_path).to eq(new_user_password_path)
end

Then(/^I should be on the sign up page$/) do
  expect(current_path).to eq(new_user_registration_path)
end

Then(/^I should be on the sign up confirmation page$/) do
  pending # express the regexp above with the code you wish you had
end
