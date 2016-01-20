$LOAD_PATH << 'lib'

require 'bomb'

a_bomb = false

Given(/^I have just booted the bomb$/) do
  a_bomb = Bomb.new
end

Then(/^the bomb active state should be false$/) do
  expect(a_bomb.active?).to be false
end

Given(/^I have not entered an activation code$/) do
  a_bomb = Bomb.new
end

Then(/^the activation code should default to (\d+)$/) do |arg1|
  expect(a_bomb.activation_code).to eq arg1
end

Given(/^I have not entered an deactivation code$/) do
  a_bomb = Bomb.new
end

Then(/^the deactivation code should default to (\d+)$/) do |arg1|
  expect(a_bomb.deactivation_code).to eq arg1
end