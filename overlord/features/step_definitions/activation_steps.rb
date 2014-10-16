require_relative '../support/env'

When(/^I activate the bomb with code '(\w+)'$/) do | act_code |
  fill_in 'activation_code', with: act_code
  click_button 'Activate!'
end

Then(/^I should see 'Activated'$/) do
  expect(page).to have_content("Activated")
end