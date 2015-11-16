def login(email, password)
  fill_in "Email", with: email
  fill_in "Password", with: password

  click_button "Login"
end

Given(/^I have a valid account$/) do
  @password = "testtest"
  @user = FactoryGirl.create(:user, password: @password)
end

Given(/^I am on the login page$/) do
  visit new_user_session_path
end

Given(/^I am logged in$/) do
  visit new_user_session_path
  login(@user.email, @password)
end

When(/^I log in with my credentials$/) do
  login(@user.email, @password)
end

When(/^I log in with the wrong email$/) do
  login("wrong@example.com", @password)
end

When(/^I log in with the wrong password$/) do
  login(@user.email, "invalid11")
end

Then(/^I see that I am logged in$/) do
  expect(page).to have_content("Signed in successfully")
end

Then(/^I see an invalid email\/password error message$/) do
  expect(page).to have_content("Invalid email or password")
end

Then(/^I am redirected to the login page$/) do
  expect(page).to have_content("Login")
end

Then(/^I see I must log in before continuing$/) do
  expect(page).to have_content("You need to sign in or sign up before continuing")
end
