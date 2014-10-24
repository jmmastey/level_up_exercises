Given(/^anything$/) do
  true
end

When(/^I hit the root page$/) do
  visit('/')
end

Then(/^I should see: (.*)\s*$/) do |text|
  page.has_content?(text) || raise("Missing (got #{text})")
end

