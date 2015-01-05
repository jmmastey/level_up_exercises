require_relative '../bomb.rb'

Given /^I boot the bomb$/ do
  @bomb = Bomb.new
end

Then /^the bomb should not be activated$/ do
  expect(@bomb.active?).to eq(false)
end