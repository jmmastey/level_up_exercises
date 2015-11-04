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

When(/^I log in with my credentials$/) do
  login(@user.email, @password)
end

Then(/^I see that I am logged in$/) do
  expect(page).to have_content("Signed in successfully.")
end
