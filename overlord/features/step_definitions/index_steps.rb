Given(/^I am on the welcome page$/) do
  visit "/"
end

When(/^I enter Megaton$/) do
  click_link "Enter Megaton"
end

Then(/^I should be directed to the bomb page$/) do
  expect(current_path).to eq "/bomb"
end
