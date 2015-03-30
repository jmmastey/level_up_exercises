BOMB_ACTIVE = 'bomb active 8)'
BOMB_INACTIVE = 'bomb inactive 8('
BOMB_DETONATED = 'ur ded 8( ...'
BOMB_DEFAULT = 'using default codes'

Then(/^I should be redirected to a page with an active bomb$/) do
  expect(page).to have_content(BOMB_ACTIVE)
end

Then(/^I should be redirected to a page with an inactive bomb$/) do
  expect(page).to have_content(BOMB_INACTIVE)
end

Then(/^I should be redirected to a page with a detonated bomb$/) do
  expect(page).to have_content(BOMB_DETONATED)
end

Then(/^I should be redirected to a page indicating that I have default codes$/) do
  expect(page).to have_content(BOMB_DEFAULT)
end
