def create_user(email, password)
  FactoryGirl.create(:user,
                     email: email,
                     password: password,
                     password_confirmation: password)
end

Given(/^the following users exist:$/) do |user_table|
  user_table.hashes.each do |user|
    create_user(user[:email], user[:password])
  end
end

Given(/^I am on the login screen$/) do
  visit('/users/sign_in')
end

When(/^I enter the email (.+)$/) do |email|
  fill_in("user_email", with: email)
end

When(/^I enter the password (.+)$/) do |password|
  fill_in("user_password", with: password)
end

Then(/^I should see the message "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end
