Given(/^I am viewing "([^"]*)"$/) do |url|
  # Webrat method
  visit(url)
end

Given(/^I can see the unbooted bomb$/) do
  visit("/")
end

Then(/^I should see "([^"]*)"$/) do |text|
  # RSpec expectations
  expect(response_body).to  match(Regexp.new(Regexp.escape(text)))
end

Then(/^I should see an unbooted bomb$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I boot the bomb with default codes$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I enter the default activation key$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^The bomb is activated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I boot the bomb with (\d+) and (\d+)$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^The bomb is not activated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I enter (\d+)$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the bomb is not activated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I activate the bomb$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the bomb warns me that I made a mistake$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I enter the default deactivation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the bomb blows up$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
