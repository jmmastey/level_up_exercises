Given(/^I have a empty shopping cart$/) do
  pending
end

When(/^I add (\d+) of "([^"]*)" to shopping cart$/) do |arg1, arg2|
  pending
  puts arg1 + arg2
end

Then(/^I should see (.*) of "([^"]*)" in the shopping cart$/) do |total, arg|
  pending
  puts total + arg
end

And(/^I should see items subtotal of \$(.*) in the shopping cart$/) do |
cart_subtotal|
  pending
  puts cart_subtotal
end
