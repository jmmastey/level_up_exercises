require_relative 'features_helper'

When(/^I enter the wrong deactivation code three times$/) do
  @bomb.deactivate(Bomb::DEACTIVATE_CODE+1)
  @bomb.deactivate(Bomb::DEACTIVATE_CODE+1)
  @bomb.deactivate(Bomb::DEACTIVATE_CODE+1)
end

Then(/^the bomb explodes$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the buttons do not work$/) do
  pending # express the regexp above with the code you wish you had
end
