Given(/^the timer has less than ten seconds left$/) do
  set_countdown_time 9
end

Given(/^the timer runs out$/) do
  set_countdown_time 0.1
  sleep(1.1)
end

Then(/^the timer should be in danger mode$/) do
  page.should have_css('#timer.danger')
end

Then(/^the timer should start counting down$/) do
  expected_seconds = timer_seconds - 1
  sleep(1.1)
  expect(timer_seconds).to be_within(0.2).of(expected_seconds)
end

def timer_seconds
  time_parts = page.find('#timer').text.split(':')
  time_parts[1].to_i + (time_parts[2].to_f / 1000)
end

def set_countdown_time(time)
  page.evaluate_script "Timer.currentTime = #{time}"
end