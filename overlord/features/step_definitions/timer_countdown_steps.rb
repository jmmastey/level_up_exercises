Given(/^the timer has less than ten seconds left$/) do
  update_countdown_time 9
end

Given(/^the timer runs out$/) do
  update_countdown_time 0
end

Then(/^the timer should be in danger mode$/) do
  page.should have_css('#timer.danger')
end

Then(/^the timer should start counting down$/) do
  expected_seconds = timer_seconds - 1
  has_counted_down = page.find('#timer').has_content?(/:#{expected_seconds}:/i)
  expect(has_counted_down).to be true
end

def timer_seconds
  time_parts = page.find('#timer').text.split(':')
  time_parts[1].to_i
end

def update_countdown_time(time)
  page.evaluate_script "Timer.currentTime = #{time}"
end
