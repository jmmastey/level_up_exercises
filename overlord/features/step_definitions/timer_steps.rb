Then(/^there should be (\d+):(\d+) left on the timer$/) do |minutes, seconds|
  find('#timer', text: "#{minutes}:#{seconds}")
end

Then(/^I should not see the timer$/) do
  expect(page).not_to have_selector('#timer')
end

And(/^I wait (\d+) seconds$/) do |seconds|
  sleep seconds.to_i
end
