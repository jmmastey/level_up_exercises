Given(/^I have 2 users$/) do
  user_1 = create(:user, email: "user1@example.com")
  user_2 = create(:user, email: "user2@example.com")
end

Given(/^I am on the users page$/) do
  visit users_path
end

Given(/^I am on the page for a user$/) do
  user_1 = create(:user, email: "user1@example.com")
  visit user_path(user_1)
end

Given(/^I am logged in$/) do
  user = create(:user, email: "user@example.com", password: "secret" )
  visit new_user_session_path
  fill_in("Email", with: "user@example.com")
  fill_in("Password", with: "secret")
  click_button("Log in")
end

Given(/^I am an admin$/) do
  user = create(:user, email: "admin@example.com", password: "secret", admin: true)
  visit new_user_session_path
  fill_in("Email", with: "admin@example.com")
  fill_in("Password", with: "secret")
  click_button("Log in")
end

When(/^I signup as a user$/) do
  visit root_path
  click_link("Sign up")
  fill_in("Email", with: "user@example.com")
  fill_in("Password", with: "password")
  fill_in("Password confirmation", with: "password")
  click_button("Sign up")
end

When(/^I signup as a user with invalid data$/) do
  click_link("Sign up")
  fill_in("Email", with: "")
  fill_in("Password", with: "")
  fill_in("Password confirmation", with: "password")
  click_button("Sign up")
end

When(/^I edit a user with valid data$/) do
  sign_up_user
  click_link("Edit Account")
  fill_in("Email", with: "myemail@example.com")
  fill_in("Current password", with: "password")
  click_button("Update Account")
end

When(/^I edit an user with invalid data$/) do
  sign_up_user
  click_link("Edit Account")
  fill_in("Email", with: "")
  click_button("Update Account")
end

When(/^I delete a user$/) do
  sign_up_user
  click_link("Delete Account")
end

Then(/^I should be on my user page$/) do
  expect(page).to have_selector('h1', text: "User Profile")
  expect(page).to have_content("user@example.com")
end

Then(/^I should see a message confirming the user was created$/) do
  expect(page).to have_content("Your account was successfully created.")
end

Then(/^I should see a message confirming the user was updated$/) do
  expect(page).to have_content("Your account was successfully updated.")
end

Then(/^I should see a message confirming the user was deleted$/) do
  expect(page).to have_content("Your account was successfully deleted.")
end

Then(/^I should see user validation errors$/) do
  expect(page).to have_content("The user could not be saved.")
  expect(page).to have_content("Please correct")
end

Then(/^I should see all the users$/) do
  expect(page).to have_content("user1@example.com")
  expect(page).to have_content("user2@example.com")
end

Then(/^I should see the user's information$/) do
  expect(page).to have_selector('h1', text: "User Profile")
  expect(page).to have_selector('p', text: "user1@example.com")
end

Then(/^I should see the updated name$/) do
  expect(page).to have_selector('p', text: "myemail@example.com")
end

Then(/^I should not see the user on the Users page$/) do
  expect(page).not_to have_content("user@example.com")
end
