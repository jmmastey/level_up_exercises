Given(/^I have a unbooted bomb$/) do
  visit "/"
end

When(/^I press the boot bomb button$/) do
	click_button('Boot')
end

#When(/^I enter code (\d+)$/) do |code|
#  fill_in('activate_code', with: code)
#end

Then (/^I see the bomb is booted messages$/) do
  expect(page).to have_content('booted')
end