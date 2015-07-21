Given(/^A bomb was booted with activation code (\d+)$/) do |code|
  visit '/boot/'
  fill_in 'activation', with: code
  click_button 'Create Bomb'
end

When(/^I enter the activation code (\d+) for a bomb$/) do |code|
  fill_in 'armingcode', with: code
  click_button 'Arm Bomb'
end

Given(/^The bomb is unarmed$/) do
  expect(page).to have_text('Bomb Armed :false ')
end

Then(/^The bomb is armed$/) do
  expect(page).to have_text('Bomb Armed :true ')
end
