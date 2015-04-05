When(/^I enter an email for a non\-existent user$/) do
  fill_in("session_email", with: INVALID_EMAIL)
end

When(/^I attempt to login$/) do
  click_button("login_btn")
end

Given(/^A valid user exists$/) do
  FactoryGirl.create(:user, password: VALID_PASSWORD)
  # Wait for record to get written to the db
  loop do
    sleep(1)
    break if User.first
  end
end

When(/^I enter the user's correct email$/) do
  user = User.first
  fill_in("session_email", with: user.email)
end

When(/^I enter the user's correct email and password$/) do
  user = User.first
  fill_in("session_email", with: user.email)
  fill_in("session_password", with: VALID_PASSWORD)
end

When(/^I enter an invalid password$/) do
  fill_in("session_password", with: INVALID_PASSWORD)
end

Then(/^I should see an error flash box$/) do
  expect(page).to have_css("div.alert")
end
