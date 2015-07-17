Given(/^A bomb is booted$/) do
    visit '/boot/'
  end

When(/^I do not enter a a custom deactivation code$/) do
  fill_in 'deactivation', with:''
  click_button 'Create Bomb'
end

When(/^I enter a a custom deactivation code (\d+)$/) do |code|
  fill_in 'deactivation', with:code
  click_button 'Create Bomb'
end

Then(/^the bomb deactivation code should be set to (\d+)$/) do |code|
  expect(page).to have_text('Bomb Deactivation Code :'+code)
end