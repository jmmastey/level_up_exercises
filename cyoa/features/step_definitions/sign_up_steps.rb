Given(/^I sign up$/) do
  @email = Faker::Internet.email
  @password = Faker::Internet.password(8)
  fill_sign_up_form(@email, @password)
end

When(/^I go to my account$/) do
  visit("/users/#{@user.id}")
end

When(/^I sign up with a used email$/) do
  user = create :user
  fill_sign_up_form(user.email, 'password')
end

Then(/^I see an email already taken message$/) do
  expect(page).to have_content('Email has already been taken')
end

When(/^I sign up with an invalid email$/) do
  fill_sign_up_form('not an email', 'password')
end

Then(/^I see an invalid email error message$/) do
  expect(page).to have_content('Email is invalid')
end

When(/^I sign up with a short password$/) do
  fill_sign_up_form('email@gmail.com', 'pwd')
end

Then(/^I see an bad password error message$/) do
  expect(page).to have_content('Password is too short')
end

def fill_sign_up_form(email, password)
  visit('/users/sign_up')
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password)
  click_button('Sign up')
end
