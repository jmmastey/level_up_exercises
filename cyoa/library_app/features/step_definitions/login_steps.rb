Given(/^I am on the home page$/) do
  visit('/')
end

When(/^I click on Login$/) do
  click_link("Login")
end

Then(/^I am redirected to the login page$/) do
  expect(page).to have_content("Log in")
  expect(page).to have_content("Email")
  expect(page).to have_content("Password")
end




Given(/^I am on the login page$/) do
  visit('/users/sign_in')
end

When(/^I click to create an account$/) do
  click_link("Sign up")
end

When(/^I enter my new account credentials$/) do
  fill_in("Email", with: "mittens@gmail.com")
  fill_in("Password", with: "testpassword")
  fill_in("Password confirmation", with: "testpassword")
  click_button("Sign up")
end

Then(/^I see that I have successfully created an account$/) do
  expect(page).to have_content("mittens@gmail.com's Library")
end



Given(/^I have created an account$/) do
  visit('/users/sign_up') 
  fill_in("Email", with: "mittens@gmail.com")
  fill_in("Password", with: "testpassword")
  fill_in("Password confirmation", with: "testpassword")
  click_button("Sign up")
  click_link("Logout")
end


When(/^I enter my credentials$/) do
  fill_in("Email", with: "mittens@gmail.com")
  fill_in("Password", with: "testpassword")
  click_button("Log in")
end

Then(/^I see that I have successfully logged in$/) do
  expect(page).to have_content("mittens@gmail.com's Library")
end

When(/^I enter incorrect user credentials$/) do
  fill_in("Email", with: "mittens@gmail.com")
  fill_in("Password", with: "cats")
  click_button("Log in")
end

Then(/^I see that I did not successfully login$/) do
  expect(page).to have_content("Log in")
end


