When(/^Super villain does not enter a a custom deactivation code$/) do
  expect(page).to have_text("Bomb status: Inactive")
  fill_in "field-custom-deactivation-code", with: ""
end

# Then(/^the bomb deactivation code should be default to (\d+)$/) do |code|
#   expect(page).to have_text("Bomb deactivation code: " + code)
# end

When(/^Super villain does enter a a custom deactivation code (\d+)$/) do |code|
  fill_in "field-custom-deactivation-code", with: code
end

Then(/^the bomb deactivation code should be set to (\d+)$/) do |code|
  expect(page).to have_text("Bomb deactivation code: " + code)
end