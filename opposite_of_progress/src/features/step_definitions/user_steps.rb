credentials = {
  email: 'login@example.com',
  password: 'Password1@'
}

su_credentials = credentials.merge(
  email: 'signup@example.com',
  password_confirmation: credentials[:password]
)

def log_in(credentials)
  fill_in 'user[email]', with: credentials[:email]
  fill_in 'user[password]', with: credentials[:password]
  click_button 'Log in'
end

def sign_up(credentials)
  fill_in 'user[email]', with: credentials[:email]
  fill_in 'user[password]', with: credentials[:password]
  fill_in 'user[password_confirmation]',
    with: credentials[:password_confirmation]
  click_button 'Sign up'
end

def reset_password(email)
  fill_in 'user[email]', with: email
  click_button 'Send me reset password instructions'
end

### Givens
Given /^I exist as a user$/ do
  User.create(credentials)
  @email = credentials[:email]
end

Given /^I am not logged in$/ do
  clear_cookies()
end

### Whens
When /^I log in with valid credentials$/ do
  log_in(credentials)
end

When /^I log in with invalid credentials$/ do
  log_in(credentials.merge(password: "#{credentials[:password]}00"))
end

When(/^I sign up with valid data$/) do
  sign_up(su_credentials)
  @email = su_credentials[:email]
end

When(/^I sign up with mismatched passwords$/) do
  sign_up(su_credentials.merge(
    password_confirmation: "#{su_credentials[:password_confirmation]}00"
  ))
end

When(/^I sign up with short password$/) do
  sign_up(su_credentials.merge(
    password: 'abcde',
    password_confirmation: 'abcde'
  ))
end

When(/^I sign up with invalid email$/) do
  sign_up(su_credentials.merge(
    email: 'abc@example'
  ))
end

When(/^I reset password with account email$/) do
  reset_password(@email)
end

When(/^I reset password with non\-registered email$/) do
  reset_password('nonregistered@example.com')
end

### Thens
Then /^I should be logged in$/ do
  within('.top-bar') do
    expect(page).not_to have_link('Log in')
    expect(page).not_to have_link('Sign up')
    expect(page).to have_link('Log out')
    expect(page).to have_content(@email)
  end

end

Then /^I should not be logged in$/ do
  within('.top-bar') do
    expect(page).to have_link('Log in')
    expect(page).to have_link('Sign up')
    expect(page).not_to have_link('Log out')
    expect(page).not_to have_content(@email)
  end
end

Then(/^I should be signed up$/) do
  within('.flash-messages') do
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end

Then(/^I should see mismatched password error$/) do
  expect(page).to have_content("doesn't match Password")
end

Then(/^I should see short password error$/) do
  expect(page).to have_content("is too short (minimum is 8 characters)")
end

Then(/^I should see invalid email error$/) do
  expect(page).to have_content("is invalid")
end

Then(/^I should see reset mail sent message$/) do
  expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
end

Then(/^I should see account not found error$/) do
 expect(page).to have_content('not found')
end
