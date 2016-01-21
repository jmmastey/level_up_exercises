$LOAD_PATH << 'lib'

require 'bomb'

a_bomb = false

Given(/^I have entered activation code ACTIVATE$/) do
  a_bomb = Bomb.new("ACTIVATE")
end

Then(/^the activation code should be ACTIVATE$/) do
  expect(a_bomb.activation_code).to eq "ACTIVATE"
end

Given(/^I have entered activation code DEACTIVATE$/) do
  a_bomb = Bomb.new("ACTIVATE", "DEACTIVATE")
end

Then(/^the activation code should be DEACTIVATE$/) do
  expect(a_bomb.deactivation_code).to eq "DEACTIVATE"
end