$LOAD_PATH << 'lib'

require 'bomb'

Given(/^A new bomb is not active$/) do
  bomb = Bomb.new("1234", "0000")
  !bomb.active?
end

When(/^I start the application$/) do
  visit("http://localhost:4567/")
end

Then(/^the game should say “Super Villain's Detonation Device”$/) do
  expect(page).to have_content "Super Villain's Detonation Device"
end

Then(/^the game should say “Please enter your code to blow things up”$/) do
  expect(page).to have_content "Please enter your code to blow things up"
end

Then(/^a form should exist with a button$/) do
  page.should have_selector(:link_or_button, 'Submit')
end
