Given(/^I am signed out$/) do
  page.driver.delete('/users/sign_out')
end

Given(/^I have an account$/) do
  @password = 'password'
  @user = create :user, password: @password
  @email = @user.email
end

When(/^I visit my account$/) do
  visit("/users/#{@user.id}")
end

When(/^I sign in correctly$/) do
  fill_sign_in_form(@email, @password)
end

Then(/^I see my account$/) do
  expect(page).to have_content('My Account')
end

Then(/^I see a welcome message$/) do
  expect(page).to have_content('Welcome! You have signed up successfully.')
end

When(/^I sign in with the wrong email$/) do
  fill_sign_in_form('bogus@good_deeds.com', @password)
end

Then(/^I see an invalid email or password message$/) do
  expect(page).to have_content('Invalid email or password.')
end

When(/^I sign in with the wrong password$/) do
  fill_sign_in_form(@email, @password + " oops")
end

def fill_sign_in_form(email, password)
  visit('/users/sign_in')
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
  click_button('Log in')
end
