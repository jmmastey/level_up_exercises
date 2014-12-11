require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)


Given(/^I'm on the homepage$/) do
  visit('bomb/new')
end

Given(/^there is no bomb created yet$/) do
  # Check the session for bomb?
end

When(/^I create a bomb$/) do
  fill_in("create_activation_code", with: '1234')
  click_on('Create!')
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(find("#bomb_status")).to have_content('Bomb is Active')
end

Then(/^I should see a field to activate the bomb$/) do
end