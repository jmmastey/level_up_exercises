When(/^an invalid countdown "([^"]*)" is provided$/) do |value|
  on(ProvisionPage).countdown_value.set(value)
end

Then(/^the display indicates the countdown value is invalid$/) do
  error_message = on(ProvisionPage).provision_error_message
  expect(error_message).to eq 'The countdown value must be a whole number.'
end

Then(/^the countdown timer will be close to "([^"]*)" seconds$/) do |seconds|
  #expect(on(TimerPage).timer.value.to_i).to be_within(2).of(seconds.to_i)
end
