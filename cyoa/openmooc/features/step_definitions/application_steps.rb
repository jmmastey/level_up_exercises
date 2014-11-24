Given(/^I am on the help page$/) do
  visit(help_path)
end

Given(/^I am on the main page$/) do
  visit(root_path)
end

When(/^I visit the main page$/) do
  visit(root_path)
end

Then(/^I should be on the main page$/) do
  expect(current_path).to eq(root_path)
end

Then(/^I should be on the feedback page$/) do
  expect(current_path).to eq(feedback_path)
end

