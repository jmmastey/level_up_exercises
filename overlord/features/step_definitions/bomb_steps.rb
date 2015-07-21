Given(/^a newly booted bomb$/) do
  on_visit(BombPage)
end

Given(/^an activated bomb$/) do
  on_visit(BombPage) do |page|
    page.enter_code('1234')
    page.change_bomb_state
  end
end

Given(/^a bomb provisioned with a custom activation code of "([^"]*)"$/) do |code|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^a bomb is booted for the first time$/) do
  on_visit(BombPage)
end

When(/^an incorrect (?:activation|deactivation) code is entered$/) do
  on(BombPage) do |page|
    page.enter_code('9999')
    page.change_bomb_state
  end
end

When(/^an invalid activation "([^"]*)" is entered$/) do |code|
  on(BombPage) do |page|
    page.enter_code(code)
    page.change_bomb_state
  end
end

When(/^an invalid deactivation "([^"]*)" is entered$/) do |code|
  on(BombPage) do |page|
    page.enter_code(code)
    page.change_bomb_state
  end
end

When(/^a valid deactivation code is entered$/) do
  on(BombPage) do |page|
    page.enter_code('0000')
    page.change_bomb_state
  end
end

When(/^the custom activation code is entered$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the default activation code "([^"]*)" is entered$/) do |code|
  on(BombPage) do |page|
    page.enter_code(code)
    page.change_bomb_state
  end
end

When(/^the default deactivation code "([^"]*)" is entered$/) do |code|
  on(BombPage) do |page|
    page.enter_code(code)
    page.change_bomb_state
  end
end

Then(/^the bomb will display as inactive$/) do
  expect(@page.bomb_status.text).to eq('Bomb is inactive.')
end

Then(/^the bomb will display as active$/) do
  expect(@page.bomb_status.text).to eq('Bomb is active.')
end

Then(/^the display indicates the activation code was incorrect$/) do
  expect(@page.notice.text).to eq('Incorrect activation code.')
end

Then(/^the display indicates the deactivation code was incorrect$/) do
  expect(@page.notice.text).to eq('Incorrect deactivation code.')
end

Then(/^the display indicates the activation code was invalid$/) do
  expect(@page.notice.text)
    .to eq('The code must be four numeric characters.')
end

Then(/^the display indicates the deactivation code was invalid$/) do
  expect(@page.notice.text)
    .to eq('The code must be four numeric characters.')
end
