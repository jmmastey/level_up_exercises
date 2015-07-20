Given(/^a newly booted bomb$/) do
  on_visit(BombPage)
end

Given(/^an active bomb$/) do
  on_visit(BombPage) do |page|
    page.enter_code('1234')
    page.change_bomb_state
  end
end

When(/^a bomb is booted for the first time$/) do
  on_visit(BombPage)
end

When(/^entering a valid activation code$/) do
  on(BombPage) do |page|
    page.enter_code('1234')
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

Then(/^the bomb will display as inactive$/) do
  expect(@page).to have_content('Bomb is inactive.')
end

Then(/^the bomb will display as active$/) do
  expect(@page).to have_content('Bomb is active.')
end

Then(/^the display indicates the activation code was invalid$/) do
  expect(@page.notice.text).to eq('Activation code was inaccurate.')
end

Then(/^the display indicates the deactivation code was invalid$/) do
  expect(@page.notice.text).to eq('Deactivation code was inaccurate.')
end
