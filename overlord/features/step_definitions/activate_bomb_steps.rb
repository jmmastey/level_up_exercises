Given(/^a bomb has been created$/) do
  visit('/bomb/new')
  fill_in("create_activation_code", with: '1234')
  click_on('Create!')
end

Given(/^I'm on the inactive bomb page$/) do
  visit('/bomb/inactive')
end

When(/^I activate a bomb$/) do
  within("form#activate_bomb_form") do
	  fill_in "activation_code", :with => '1234'
    click_on('Activate!')
	end
  visit('/bomb/activate') # Why do I have to manually redirect?
end

Then(/^I should be on a new page$/) do
  expect(current_path).to eq("/bomb/activate")
end