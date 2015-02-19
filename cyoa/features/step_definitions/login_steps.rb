Given(/^I am not logged in$/) do
  # No Action - Not logged in by default after app start
end

Given(/^I am logged in$/) do
  visit new_user_session_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Log in"
end

Given(/^I am on the login page$/) do
  visit new_user_session_path
end

When(/^I submit a valid login$/) do
  step "I am logged in"
end

Then(/^I receive a successful login message$/) do
  expect(page).to have_content("Signed in successfully")
end

When(/^I submit a blank login$/) do
  click_button "Log in"
end

Then(/^I receive a login error message$/) do
  expect(page).to have_content("Invalid email or password")
end

When(/^I submit an invalid login$/) do
  fill_in "Email", with: "joetestzzer"
  fill_in "Password", with: "va"
  click_button "Log in"
end
