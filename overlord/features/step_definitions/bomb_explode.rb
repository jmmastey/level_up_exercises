#encoding: utf-8

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

Then(/^I should be unable to (?:dis)?arm the bomb$/) do
  find('#password[disabled]')
  find('#confirm[disabled]')
end