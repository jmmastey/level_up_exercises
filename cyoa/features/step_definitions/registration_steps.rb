Given(/^I am not a registered user$/) do

end

Given(/^I am on the registration page$/) do
  visit new_user_registration_path
end

Given(/^some registered users$/) do
  @user = FactoryGirl.create(:user)
end

When(/^I submit a new valid registration$/) do
  fill_in "Email", with: "joetestzzer@gmail.com"
  fill_in "Password", with: "validpassword1"
  fill_in "Password confirmation", with: "validpassword1"
  click_button "Sign up"
end

When(/^I submit a blank registration$/) do
  click_button "Sign up"
end

When(/^I submit an invalid registration$/) do
  fill_in "Email", with: "joetestzzer"
  fill_in "Password", with: "va"
  fill_in "Password confirmation", with: "va"
  click_button "Sign up"
end

Then(/^I am redirected to the home page$/) do
  expect(current_path).to eq('/')
end

Then(/^I receive a successful registration message$/) do
  expect(page).to have_content("Welcome! You have signed up successfully.")
end

Then(/^I receive a registration error message$/) do
  expect(page).to have_content("errors prohibited this user from being saved")
end

When(/^I submit a new registration with an existing user email$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  fill_in "Password confirmation", with: @user.password
  click_button "Sign up"
end

Then(/^I receive a user exists message$/) do
  expect(page).to have_content("Email has already been taken")
end

