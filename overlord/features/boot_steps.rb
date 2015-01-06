require_relative 'features_helper'

Given /^I have not booted the bomb$/ do

end

When /^I boot the bomb$/ do
  @bomb = Bomb.new
end

Then /^the bomb should not be activated$/ do
  expect(@bomb.active?).to eq(false)
end
