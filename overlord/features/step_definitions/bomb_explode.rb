# encoding: utf-8

Given(/^I have already submitted my codes$/) do
  @arm_actual = @default_arm
  @disarm_actual = @default_disarm
  find('#submit-codes').click
end

When(/^the timer hits zero$/) do
  submit_button = '.columns > '
  submit_button << '.column:first-child > '
  submit_button << 'input[type="submit"]'

  12.times do
    find(submit_button).click
  end
end

Then(/^the bomb should explode$/) do
  @start_time = "0000"
  find('.bomb.detonated')
end

Then(/^I should be (un)?able to (?:dis)?arm the bomb$/) do |unable|
  if unable
    find('#password[disabled]')
    find('#confirm[disabled]')
  else
    find('#password:not([disabled])')
    find('#confirm:not([disabled])')
  end
end
