#encoding: utf-8
require './classes/bomb.rb'

Given(/^the bomb is (dis)?armed$/) do |disarmed|
  selector = '.bomb'
  if disarmed
    selector << '.disarmed'
  else 
    find('#password').set(@arm_actual)
    find('#confirm').click

    selector << ":not(.disarmed)"
  end
  find(selector)
end

When(/^I enter the (in)?correct (arm|disarm) code(?: again)?$/) do |incorrect, mode|
  if mode == 'arm'
    code = incorrect ? @default_incorrect : @arm_actual
  else
    code = incorrect ? @default_incorrect : @disarm_actual
  end

  find('#password').set(code)
  find('#confirm').click

  @start_time = find('.minutes').text + find('.seconds').text
end

Then(/^the bomb should (not )?(dis)?arm$/) do |should_not, disarm|
  selector = '.bomb'
  if disarm
    selector << (should_not ? ':not(.disarmed)' : '.disarmed')
  else
    selector << (should_not ? '.disarmed' : ':not(.disarmed)')
  end
  find(selector)
end

Then(/^the timer should (not )?(start|stop)$/) do |should_not, action|
  sleep 1

  time = find('.minutes').text + find('.seconds').text
  shouldnt_start = should_not && action == 'start'
  should_stop = !should_not && action == 'stop'

  if shouldnt_start || should_stop
    expect(time).to eq(@start_time)
  else
    expect(time).not_to eq(@start_time)
  end
end
