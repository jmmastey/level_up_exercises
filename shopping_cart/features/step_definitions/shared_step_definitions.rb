When(/^I login as "([^"]*)"$/) do |arg|
  pending
  puts arg
end

Then(/^I should see (.*) of "([^"]*)" in shopping cart$/) do |item_total, arg|
  pending
  puts item_total + arg
end

And(/^I should see items subtotal of \$(.*) in shopping cart$/) do |subtotal|
  pending
  puts subtotal
end

And(/^"(.*?)" which costs \$(\d+)\.(\d+)$/) do |arg1, arg2, arg3|
  pending
  puts arg1 + arg2 + arg3
end

Given(/^I have a shopping cart with (\d+) "([^"]*)" in it$/) do |arg1, arg2|
  pending
  puts arg1 + arg2
end

And(/^I am on the shopping cart page$/) do
  pending
end

And(/^I press "([^"]*)"$/) do |arg|
  pending
  puts arg
end

When(/^I set "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  pending
  puts arg1 + arg2
end

And(/^I should see message "([^"]*)"$/) do |arg|
  pending
  puts arg
end
