require_relative 'features_helper'

When(/^I enter the wrong deactivation code three times$/) do
  @bomb.deactivate(1111)
  @bomb.deactivate(1111)
  @bomb.deactivate(1111)
end

Then(/^the bomb explodes$/) do
  expect(@bomb.detonated?).to eq(true)
end

Then(/^the buttons do not work$/) do
  pending # express the regexp above with the code you wish you had
end
