Given(/^there are 0 bombs$/) do
  visit '/'
  expect(page).to have_content('No bomb created yet')
end

When(/^I create a bomb$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^enter an activation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^enter a deactivation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^there should be (\d+) bomb$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^there should be a bomb with an activation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^there should be deactivation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the status should be inactive$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
