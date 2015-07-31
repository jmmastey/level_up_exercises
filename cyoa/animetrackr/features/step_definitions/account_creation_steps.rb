Given(/^I do not have an account$/) do
  expect(User.exists?(email: USER[:email])).to be(false)
end

Given(/^I have an account$/) do
  sign_up(USER[:username], USER[:email], USER[:password])
  sign_out
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
  expect(current_path).to eq(profile_path)
end

When(/^I enter an invalid username, (.+)$/) do |username|
  fill_in(:user_username, with: username)
end

Then(/^I expect to have a username is too short error$/) do
  expect(page).to have_content('Username is too short')
end

Then(/^I expect to have a username must contain letters error$/) do
  expect(page).to have_content('Username must contain at least 1 letter')
end

Then(/^I should not view my profile page$/) do
  expect(current_path).not_to eq(profile_path)
end

When(/^I enter an invalid password, (.+)$/) do |password|
  fill_in(:user_password, with: password)
end

Then(/^I should expect to have a password is too short error$/) do
  expect(page).to have_content('Password is too short')
end

Then(/^I should expect to have an invalid password error$/) do
  expect(page).to have_content('Password must contain at least 1 lowercase, 1 uppercase and 1 number')
end

When(/^I enter an invalid email, (.+)$/) do |email|
  fill_in(:user_email, with: email)
end

Then(/^I should expect to have an email error$/) do
  expect(page).to have_content('Email is invalid')
end

When(/^I enter a username that is taken$/) do
  User.create(email: 'test@example.com', username: USER[:username], 
              password: USER[:password], password_confirmation: USER[:password])
  fill_in(:user_username, with: USER[:username])
end

Then(/^I should expect to have a username taken error$/) do
  expect(page).to have_content('Username has already been taken')
end

When(/^I enter an email that is taken$/) do
  User.create(email: USER[:email], username: 'test_user', 
              password: USER[:password], password_confirmation: USER[:password])
  fill_in(:user_email, with: USER[:email])
end

Then(/^I should expect to have an email taken error$/) do
  expect(page).to have_content('Email has already been taken')
end
