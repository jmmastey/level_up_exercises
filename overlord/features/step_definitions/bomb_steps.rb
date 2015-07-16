Given(/^a newly booted bomb$/) do
  @bomb_page = BombPage.new
  @bomb_page.load
end

When(/^a bomb is booted for the first time$/) do
  @bomb_page = BombPage.new
  @bomb_page.load
end

When(/^entering a valid activation code$/) do
  @bomb_page.enter_valid_activation_code
  @bomb_page.activate_bomb
end

Then(/^the bomb will display as inactive$/) do
  expect(@bomb_page).to have_content('Bomb is inactive.')
end

Then(/^the bomb will display as active$/) do
  expect(@bomb_page).to have_content('Bomb is active.')
end
