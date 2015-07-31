Given /^there is a user$/ do
  create(:user)
end

Given /^the user is not logged in$/ do
  expect(first('#sign_in_btn')).to_not be_nil
end

Given /^the user is logged in$/ do
  click_link('Sign In')
  u = build(:user)
  fill_in 'user_email', with: u.email
  fill_in 'user_password', with: u.password
  click_button 'Log In'
end

When /^the user fills out the sign up form(.*)$/ do |wrong|
  user = build(:user)
  fill_in "user_username", with: user.username
  fill_in "user_email", with: user.email
  fill_in "user_password", with: user.password
  if wrong.empty?
    fill_in "user_password_confirmation", with: user.password_confirmation
  end
  fill_in "user_first_name", with: user.first_name
  fill_in "user_last_name", with: user.last_name
  fill_in "user_biography", with: user.biography
end

When /^the user fills in the login form with (.*) and (.*)$/ do |user, password|
  fill_in "user_email", with: user
  fill_in "user_password", with: password
end

When /^the user fills in the login form$/ do
  u = build(:user)
  fill_in "user_email", with: u.email
  fill_in "user_password", with: u.password
end

When /^the user goes to their profile page$/ do
  u = User.first
  visit user_profile_path(u)
end

When /^the user changes their name$/ do
  fill_in "user_first_name", with: "NEW CHARACTERS"
end

When /^the user fills in their current password as: (.*)$/ do |password|
  fill_in "user_current_password", with: password
end

Then /^the menu should (.*)contain (.*)$/ do |state, item|
  if state == "not "
    expect { find('.navbar').find_link(item) }.to raise_error(Capybara::ElementNotFound)
  else
    expect(find('.navbar').find_link(item)).to_not eq(nil)
  end
end

Then /^the user will be signed (.*)$/ do |state|
  if state == "in"
    expect(first('#sign_in_btn')).to be_nil
  elsif state == "out"
    expect(first('#sign_out_btn')).to be_nil
  end
end

Then /^there will be a new user$/ do
  expect(find('.alert')).to have_content("Welcome! You have signed up successfully")
end

Then /^there will be a devise error: (.*)$/ do |error|
  expect(find('.alert')).to have_content(error)
end

Then /^the user will be logged in$/ do
  expect(first('#sign_out_btn')).to_not be_nil
end

Then /^the user should (.*)see an (.*) link$/ do |state, name|
  if state == "not "
    expect { find_link(name) }.to raise_error(Capybara::ElementNotFound)
  else
    expect(find_link(name)).to_not eq(nil)
  end
end

Then /^the user account will be updated$/ do
  expect(page.html).to have_content("Your account has been updated successfully.")
end
