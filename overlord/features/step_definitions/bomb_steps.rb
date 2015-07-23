When(/^the bomb is activated$/) do
  on(BombPage) do |page|
    page.enter_code('1234')
    page.activate_bomb
  end
end

When(/^the bomb is deactivated$/) do
  on(BombPage) do |page|
    page.enter_code('0000')
    page.deactivate_bomb
  end
end

When(/^the bomb is activated with the custom activation code$/) do
  on(BombPage) do |page|
    page.enter_code('9292')
    page.activate_bomb
  end
end

When(/^the bomb is deactivated with the custom deactivation code$/) do
  on(BombPage) do |page|
    page.enter_code('1234')
    page.activate_bomb
    page.enter_code('1138')
    page.deactivate_bomb
  end
end

When(/^an invalid activation "([^"]*)" is entered$/) do |code|
  on(BombPage) do |page|
    page.enter_code(code)
    page.deactivate_bomb
  end
end

When(/^an invalid deactivation "([^"]*)" is entered$/) do |code|
  on(BombPage) do |page|
    page.enter_code('1234')
    page.activate_bomb
    page.enter_code(code)
    page.deactivate_bomb
  end
end

When(/^an incorrect activation code is entered$/) do
  on(BombPage) do |page|
    page.enter_code('9292')
    page.activate_bomb
  end
end

When(/^an incorrect deactivation code is entered$/) do
  on(BombPage) do |page|
    page.enter_code('1234')
    page.activate_bomb
    page.enter_code('1138')
    page.deactivate_bomb
  end
end

When(/^an incorrect deactivation code is entered three times$/) do
  on(BombPage) do |page|
    page.enter_code('1138')
    page.deactivate_bomb
    page.enter_code('1138')
    page.deactivate_bomb
    page.enter_code('1138')
    page.deactivate_bomb
  end
end

Then(/^the bomb will display as active$/) do
  bomb_state = on(BombPage).displayed_bomb_state
  expect(bomb_state).to eq('Bomb is active.')
end

Then(/^the bomb will display as inactive$/) do
  bomb_state = on(BombPage).displayed_bomb_state
  expect(bomb_state).to eq('Bomb is inactive.')
end

Then(/^the countdown timer will be set to "([^"]*)" seconds$/) do |seconds|
  seconds_remaining = on(BombPage).timer_value_in_seconds
  expect(seconds_remaining).to eq(seconds)
end

Then(/^the timer will start counting down$/) do
  counting_down = on(BombPage).timer_state
  expect(counting_down).to eq('true')
end

Then(/^the timer will stop counting down$/) do
  counting_down = on(BombPage).timer_state
  expect(counting_down).to eq('false')
end

Then(/^the countdown timer will be set to the custom countdown value$/) do
  seconds_remaining = on(BombPage).timer_value_in_seconds
  expect(seconds_remaining).to eq('15')
end

Then(/^the bomb display indicates the activation code was invalid$/) do
  message = on(BombPage).bomb_message
  expect(message).to eq('The code must be four numeric characters.')
end

Then(/^the bomb display indicates the deactivation code was invalid$/) do
  message = on(BombPage).bomb_message
  expect(message).to eq('The code must be four numeric characters.')
end

Then(/^the bomb display indicates the activation code was incorrect$/) do
  message = on(BombPage).bomb_message
  expect(message).to eq('Incorrect activation code.')
end

Then(/^the bomb display indicates the deactivation code was incorrect$/) do
  message = on(BombPage).bomb_message
  expect(message).to eq('Incorrect deactivation code.')
end

Then(/^the bomb will detonate$/) do
  check = on(BombPage).check_if_detonated
  expect(check).not_to be_nil
end
