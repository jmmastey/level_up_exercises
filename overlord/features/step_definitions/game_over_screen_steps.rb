Then(/^I should( not)? see the game over screen$/) do |notVisible|
  page.should have_selector('#game-over', visible: !notVisible)
end

When(/^I click the try again button$/) do
  click_link('Try again?')
end
