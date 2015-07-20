Given(/^there are 0 bombs$/) do
  http_delete '/bomb/delete'
  visit '/'
  expect(page).to have_content('No bomb created yet')
end

When(/^I create a bomb$/) do
end

When(/^enter an activation code$/) do
  fill_in('activation_code', with: '1234')
end

When(/^enter a deactivation code$/) do
  fill_in('deactivation_code', with: '2345')
  click_button('Create Bomb')
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
