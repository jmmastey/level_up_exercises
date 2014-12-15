Given(/^I'm on the homepage$/) do
  visit('/')
end

Given(/^there is no bomb created yet$/) do
  # Check the session for bomb?
end

When(/^I create a bomb$/) do
  fill_in("create_activation_code", with: '1234')
  click_on('Create!')
end
