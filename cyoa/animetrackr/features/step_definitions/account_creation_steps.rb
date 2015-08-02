Given(/^I do not have an account$/) do
  user = build(:user)
  expect(User.exists?(email: user.email)).to be(false)
end

Given(/^I have an account$/) do
  user = build(:user)
  sign_up(user.username, user.email, user.password)
  sign_out
end

Given(/^I visit the sign up page$/) do
  visit(new_user_registration_path)
end

When(/^I enter my username$/) do
  user = build(:user)
  fill_in(:user_username, with: user.username)
end

When(/^I enter my password$/) do
  user = build(:user)
  fill_in(:user_password, with: user.password)
end

When(/^I enter my confirmation password$/) do
  user = build(:user)
  fill_in(:user_password_confirmation, with: user.password)
end

When(/^I enter my email address$/) do
  user = build(:user)
  fill_in(:user_email, with: user.email)
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
  user = create(:user)
  fill_in(:user_username, with: user.username)
end

Then(/^I should expect to have a username taken error$/) do
  expect(page).to have_content('Username has already been taken')
end

When(/^I enter an email that is taken$/) do
  user = create(:user)
  fill_in(:user_email, with: user.email)
end

Then(/^I should expect to have an email taken error$/) do
  expect(page).to have_content('Email has already been taken')
end
