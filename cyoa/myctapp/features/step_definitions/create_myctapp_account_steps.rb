Given(/^I am on the sign up page$/) do
  visit("/signup")
end

When(/^I fill out my correct information$/) do
  fill_in("user_name", with: "Test Account")
  fill_in("user_email", with: "dummy@example.com")
  fill_in("user_password", with: "Testcase123")
  fill_in("user_password_confirmation", with: "Testcase123")
end

When(/^hit submit$/) do
  click_button("Create my account")
end

Then(/^I should be signed in and on my profile$/) do
  expect(page).to have_content("Thanks for creating a MyCTApp account!")
end
