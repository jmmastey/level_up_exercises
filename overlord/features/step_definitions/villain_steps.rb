require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)


Given(/^there is no bomb created yet$/) do
	true
end

When(/^I create a bomb$/) do
	visit '/bombs/new'
	fill_in('Activation Code', :with => '1234')
	click_on('Create!')
end

Then(/^the bomb should be created$/) do
	expect(current_path).to eq('/bombs/new')
end