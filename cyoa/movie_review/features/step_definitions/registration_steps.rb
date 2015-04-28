When(/^I click 'Sign Up to Write A Review'$/) do
  click_link('Sign Up to Write A Review')
end

Then(/^I see registration form$/) do
  visit('https://be-a-critique.herokuapp.com/users/sign_up')
  expect(page).to have_field('user_email')
  expect(page).to have_field('user_password')
  expect(page).to have_field('user_password_confirmation')
  expect(page).to have_button('Sign up')
  expect(page).to have_link('Log in')
end

When(/^I enter valid email$/) do
  fill_in('user_email', with: 'brucewyane@bwindustries.com')
end

When(/^I enter valid password$/) do
  fill_in('user_password', with: 'why-do-we-fall?!')
end

When(/^I enter same password for confirmation$/) do
  fill_in('user_password_confirmation', with: 'why-do-we-fall?!')
end

When(/^I click 'Sign up'$/) do
  click_button('Sign up')
end

When(/^I enter invalid email$/) do
  fill_in('user_email', with: 'abcd@1')
end

Then(/^I see error message for invalid email$/) do
expect(page). to have_content('Email is invalid')
end

When(/^I do not enter password$/) do
  fill_in('user_password', with: "")
end

When(/^I do not enter password for confirmation$/) do
  fill_in('user_password_confirmation', with: "")
end

Then(/^I see error message for empty password$/) do
  expect(page).to have_content('Password can\'t be blank')
end

When(/^I enter password that is to short$/) do
  fill_in('user_password', with: 'abc')
end

Then(/^I see error message for too short password$/) do
	expect(page).to have_content('Password is too short (minimum is 8 characters)')
end