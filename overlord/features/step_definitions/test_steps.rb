Given(/^I am viewing "([^"]*)"$/) do |url|
  # Webrat method
  visit(url)
end

Then(/^I should see "([^"]*)"$/) do |text|
  # RSpec expectations
  expect(response_body).to  match(Regexp.new(Regexp.escape(text)))
end
