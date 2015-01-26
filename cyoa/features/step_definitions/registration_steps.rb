Given(/^I am not a registered user$/) do

end

Given(/^I am on the registration page$/) do
  visit new_user_registration_path
end

When(/^I fill in a valid registration email and password$/) do
  fill_in "Email", with: "joetestzzer@gmail.com"
  fill_in "Password", with: "validpassword1"
  click_button "Register"
end

Then(/^I am redirected to the home page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I receive a successful registration message$/) do
  pending # express the regexp above with the code you wish you had
end
