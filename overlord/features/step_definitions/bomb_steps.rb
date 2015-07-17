Given(/^a newly booted bomb$/) do
  on_visit(BombPage).load
end

When(/^a bomb is booted for the first time$/) do
  on_visit(BombPage).load
end

When(/^entering a valid activation code$/) do
  on(BombPage) do |page|
    page.enter_valid_activation_code('1234')
    page.activate_bomb
  end
end

When(/^entering an invalid activation "([^"]*)"$/) do |code|
  on(BombPage) do |page|
    page.enter_valid_activation_code(code)
    page.activate_bomb
  end
end

Then(/^the bomb will display as inactive$/) do
  expect(@page).to have_content('Bomb is inactive.')
end

Then(/^the bomb will display as active$/) do
  expect(@page).to have_content('Bomb is active.')
end

Then(/^the display indicates the code was invalid$/) do
  expect(@page.notice.text).to eq('Activation code was inaccurate.')
end
