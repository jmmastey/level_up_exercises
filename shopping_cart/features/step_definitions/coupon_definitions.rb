And(/^a coupon for "([^"]*)" off with code "([^"]*)"$/) do |arg1, arg2|
  pending
  puts arg1 + arg2
end

And(/^a invalid coupon for "([^"]*)" off with code "([^"]*)"$/) do |arg1, arg2|
  pending
  puts arg1 + arg2
end

Then(/^I should see total discount of "([^"]*)"$/) do |arg|
  pending
  puts arg
end
