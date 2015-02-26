Given(/^I am at the account creation page$/) do
  visit("/signup")
end

Given(/^I have entered a valid name, email and password$/) do
  fill_in("Name", with: Faker::Lorem.name)
  fill_in("Email", with: Faker::Internet.email)
  fill_in("Password", with: "password")
  fill_in("Confirmation", with: "password")
end

When(/^I try to create an account$/) do
  click_button("Create my account")
end

Then(/^my account is created$/) do
  expect(page).to have_selector(".user_info")
end

Given(/^I have not entered a name$/) do
  fill_in("Email", with: Faker::Internet.email)
  fill_in("Password", with: "password")
  fill_in("Confirmation", with: "password")
end

Then(/^my account is not created and I see an error$/) do
  expect(page).to have_selector("#error_explanation")
  expect(page).to have_button("Create my account")
end

Given(/^I have entered an invalid email address$/) do
  fill_in("Name", with: Faker::Lorem.name)
  fill_in("Email", with: "lalala@gmail,com")
  fill_in("Password", with: "password")
  fill_in("Confirmation", with: "password")
end

Given(/^I have entered a password confirmation that is not the password$/) do
  fill_in("Name", with: Faker::Lorem.name)
  fill_in("Email", with: Faker::Internet.email)
  fill_in("Password", with: "password")
  fill_in("Confirmation", with: "Password")
end
