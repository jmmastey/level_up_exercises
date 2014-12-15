Given(/^a bomb has been created$/) do
  visit('/')
  fill_in("create_activation_code", with: '1234')
  click_button('Create!')
end

Given(/^I'm on the inactive bomb page$/) do
end

When(/^I activate a bomb$/) do
  fill_in "activation_code", :with => '1234'
  click_button('Activate!')
end

Then(/^I should be on a new page$/) do
  # This step was actually more for debugging...
  expect(current_path).to eq("/bomb/active")
end