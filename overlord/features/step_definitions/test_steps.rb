Given(/The bomb is not started/)
  true
end

When(/^I start the bomb$/)
  visit('/')
end

Then(/^I should see: (.*)\s*$/) do |text|
  page.has_content?(text) || raise("Missing (got #{text})")
end

