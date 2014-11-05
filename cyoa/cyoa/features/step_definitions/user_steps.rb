def create_visitor
  @visitor ||= { email: "someone@enova.com",
                 password: "password",
                 password_confirmation: "password"
                }
end

def submit_signup_form
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
end

Given(/^I am not logged in$/) do
  #visit "/users/sign_out"
end

Given(/^I go to the signup page$/) do
  visit "users/sign_up"
end

When(/^I submit valid email and password$/) do
  create_visitor
  submit_signup_form
end

When(/^I submit invalid email and valid password$/) do
  create_visitor
  @visitor = @visitor.merge(email: "invalid")
  submit_signup_form
end

When(/^I submit valid email and invalid password$/) do
  create_visitor
  @visitor = @visitor.merge(password: "pwd", password_confirmation: "pwd")
  submit_signup_form
end

When(/^I submit valid email\/password and differing confirmation$/) do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "somethingelse")
  submit_signup_form
end

Then(/^I see the message "(.*?)"$/) do |message|
  expect(page).to have_content message
end
