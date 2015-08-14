def create_user(password)
  @user = create(:user, password: password)
  @username = @user.username
  @password = password
end

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
  create_user('123456')
end

When(/^I update my (.*) to be (.*)$/) do |field, value|
  visit(edit_user_path(@user))
  fill_in "user[#{field}]", with: value
  click_button 'Update'
end

Then(/^my (.*) should be (.*)$/) do |field, value|
  visit(edit_user_path(@user))
  expect(find_field("user[#{field}]").value).to eq(value)
end

When(/^I destroy my account$/) do
  visit(edit_user_path(@user))
  click_link("Destroy Account")
end

Then(/^my account should be destroyed$/) do
  expect(@user).to be_nil
end
