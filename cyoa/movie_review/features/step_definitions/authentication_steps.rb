When(/^I click on 'Log in'$/) do
  click_link('Log in')
end

Then(/^I see 'Email' field$/) do
  expect(page).to have_field('user_email')
end

Then(/^I see 'Password' field$/) do
  expect(page).to have_field('user_password')
end

Then(/^I see 'Log in' button$/) do
  expect(page).to have_button('Log in')
end

Given(/^I visit login page$/) do
  visit('https://be-a-critique.herokuapp.com/users/sign_in')
end

When(/^I enter correct email$/) do
  fill_in('user_email', with: 'khadilkar.c@gmail.com')
end

When(/^I enter correct password$/) do
  fill_in('user_password', with: 'khadilkarc123')
end

When(/^I click 'Log in' button$/) do
  click_button('Log in')
end

Given(/^I am logged in$/) do
  FactoryGirl.create(:user)
  @user = User.first
  visit('https://be-a-critique.herokuapp.com/users/sign_in')
  fill_in('user_email', with: "#{@user.email}")
  fill_in('user_password', with: "fake_password")
  click_button('Log in')
end

When(/^I click 'Logout' link$/) do
  visit(destroy_user_session_path)
end

Then(/^I see 'Log in' link$/) do
  expect(page).to have_link('Log in')
end

When(/^I enter invalid password$/) do
  fill_in('user_password', with: 'qwerty')
end

Then(/^I see error message$/) do
  expect(page).to have_content('Invalid email or password.')
end

When(/^I enter junk characters email$/) do
  fill_in('user_email', with: 'aafaf@1')
end

When(/^I click 'Login' button$/) do
  click_button('Log in')
end