require_relative 'features_helper'

Given(/^I have booted the bomb$/) do
  @bomb = Bomb.new
end

When(/^I enter the right activation code$/) do
  @bomb.activate(1234)
end

When(/^I enter the right deactivation code$/) do
  @bomb.deactivate(0000)
end

Then(/^the bomb should activate$/) do
  expect(@bomb.active?).to be(true)
end

Then(/^the status indicator should show as activated$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the status indicator should show as deactivated$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the bomb should deactivate$/) do
  expect(@bomb.active?).to be(false)
end
