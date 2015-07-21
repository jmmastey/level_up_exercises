Given(/^there are no bombs$/) do
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
end

When(/^press the create button$/) do
  click_button('Create Bomb')
end

Then(/^there should be a bomb$/) do
  expect(page).not_to have_content('No bomb created yet')
  find_button('Activate')
  find_button('Deactivate')
end

Then(/^the status should be inactive$/) do
  expect(page).to have_content('INACTIVE')
end
