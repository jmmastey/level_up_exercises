require_relative 'helpers'

Given(/^the bomb is not armed$/) do
  boot_bomb_with_default
  visit 'arm_bomb'
end

Given(/^I have a booted bomb with default values$/) do
  boot_bomb_with_default
  visit 'arm_bomb'
end

Given(/^I have an armed bomb with default values$/) do
  arm_bomb_with_default
end

