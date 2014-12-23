When(/^I signup as a user$/) do
  visit path
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

Then(/^I should be on my user page$/) do
  expect(page).to have_selector('h1', text: "User Profile Page")
  expect(page).to have_content("user@example.com")
end

Then(/^I should see a message confirming the user was created$/) do
  expect(page).to have_content("user@example.com")
end

Then(/^I should see user validation errors$/) do
  expect(page).to have_content("The user could not be saved.")
  expect(page).to have_content("Please correct")
end
