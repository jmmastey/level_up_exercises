Given(/^I visit the sign up page$/) do
  visit('/signup')
end

When(/^I enter valid information$/) do
  pass = '123456'
  fill_in 'user[username]', with: 'test_user'
  fill_in 'user[email]', with: 'test_user@example.com'
  fill_in 'user[password]', with: pass
  fill_in 'user[password_confirmation]', with: pass
end

When(/^I sign up$/) do
  click_button 'Sign Up'
end

Then(/^a new user should be saved$/) do
  expect(User.all.count).to eq(1) 
end

Given(/^I created a user$/) do
  @user = create(:user, password: '123456')
end

When(/^I log in$/) do
  visit('/login')
  fill_in 'user[username]', with: @user.username
  fill_in 'user[password]', with: '123456'
  click_button 'Log In'
end

Then(/^I should be taken to the user profile page$/) do
  pending
end