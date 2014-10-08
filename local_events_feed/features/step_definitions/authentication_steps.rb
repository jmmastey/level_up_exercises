require_relative 'step_helpers'

Given /^a user visits the welcome page$/ do
  visit(root_path)
end

Given /^a user visits the signin page$/ do
  visit_signin_page
end

Given /^a user visits the signup page$/ do
  visit_signup_page
end

Given /^the user has an account$/ do
  @user = create_user
end

Given /^a signed-in user$/ do
  user_signs_in
end

When /^they submit valid signin information$/ do
  fill_in('Email', with: @user.email)
  fill_in('Password', with: @user.password)
  click_button("Sign-In")
end

When /^they submit invalid signin information$/ do
  click_button("Sign-In")
end

When /^they click on signout$/ do
  click_link('Logout')
end

When /^they submit valid signup information$/ do
  fill_in('Name', with: 'John Smith')
  fill_in('Email', with: 'jsmith@besthost.com')
  fill_in('Password', with: 'pass-me')
  fill_in('Password confirmation', with: 'pass-me')
  click_button("Sign-Up!")
end

When /^they submit invalid signup information$/ do
  fill_in('Name', with: 'John Smith')
  fill_in('Email', with: 'jsmith@besthost.com')
  fill_in('Password', with: 'pass-me')
  fill_in('Password', with: 'fail-me')
  click_button("Sign-Up!")
end

Then /^they should see the signin page$/ do
  expect(page).to have_content('Sign in')
end

Then /^they should see the signup page$/ do
  expect(page).to have_content(signup_heading_msg)
end

Then /^they should see the events page$/ do
  expect(page).to have_content(events_page_msg('John Smith'))
end

Then /^they should see themselves logged in$/ do
  expect(page).to have_content(events_page_msg('John Smith'))
end

Then /^they should see the welcome heading$/ do
  expect(page).to have_content(welcome_heading_msg)
end

Then /^they should see a signout link$/ do
  expect(page).to have_link('Logout', session_destroy_link)
end

Then /^they should see signup errors$/ do
  expect(page).to have_content('Issue')
end



def create_user(name = 'John Smith', email = 'jsmith@besthost.com', password = 'pass-me', confirm = 'pass-me')
  User.create(name: name,
              email: email,
              password: password,
              password_confirmation: confirm)
end

def visit_signin_page
  visit(new_session_path)
end

def visit_signup_page
  visit(new_user_path)
end

def user_signs_in
  visit_signin_page
  @user = create_user
  fill_in('Email', with: @user.email)
  fill_in('Password', with: @user.password)
  click_button("Sign-In")
end

def welcome_heading_msg
  'Welcome to Local Events Feed'
end

def signup_heading_msg
  'Please fill out the form below'
end

def events_page_msg(name)
  "Logged-In: #{name}"
end

def session_destroy_link
  '/sessions/0'
end
