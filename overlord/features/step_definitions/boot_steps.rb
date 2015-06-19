Given(/^I have a unbooted bomb$/) do
  visit "/"
end

When(/^I press the boot bomb button$/) do
  click_button('Boot')
end

Then(/^I see the bomb is booted messages$/) do
  expect(page).to have_content('booted')
end
