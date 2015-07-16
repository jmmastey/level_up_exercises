When(/^a bomb is booted for the first time$/) do
  visit '/'
end

Then(/^the bomb will display as inactive$/) do
  expect(page).to have_content('Bomb is inactive.')
end
