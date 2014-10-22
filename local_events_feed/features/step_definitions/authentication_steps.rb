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
  create_user
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

Then /^they see the signin page$/ do
  expect(page).to have_content('Sign in')
end

Then /^they see the signup page$/ do
  expect(page).to have_content(signup_heading_msg)
end

Then /^they see their own page$/ do
  expect(page).to have_title(user_page_msg('John'))
end

Then /^they see themselves logged in$/ do
  expect(page).to have_content(logged_in_msg('John Smith'))
end

Then /^they see the welcome heading$/ do
  expect(page).to have_content(welcome_heading_msg)
end

Then /^they see a signout link$/ do
  expect(page).to have_link('Logout', session_destroy_link)
end

Then /^they see signup errors$/ do
  expect(page).to have_content('Issue')
end

Then /^they see authentication-failure message$/ do
  expect(page).to have_content('Wrong email and/or password')
end


def visit_signin_page
  visit(new_session_path)
end

def visit_signup_page
  visit(new_user_path)
end

def welcome_heading_msg
  'Welcome to Local Events Feed'
end

def signup_heading_msg
  'Please fill out the form below'
end

def logged_in_msg(name)
  "Logged-In: #{name}"
end

def session_destroy_link
  '/sessions/0'
end
