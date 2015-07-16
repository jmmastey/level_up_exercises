When(/^a bomb is booted for the first time$/) do
  @bomb_page = BombPage.new
  @bomb_page.load
end

Then(/^the bomb will display as inactive$/) do
  expect(@bomb_page).to have_content('Bomb is inactive.')
end
