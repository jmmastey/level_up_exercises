And(/^"(.*?)" shipping costs \$(\d+)\.(\d+) each$/) do |arg1, arg2, arg3|
  pending
  puts arg1 + arg2 + arg3
end

Then(/^I should see shipping cost to be "([^"]*)"$/) do |arg|
  pending
  puts arg
end
