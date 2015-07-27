def create_and_arm_bomb
  fill_in 'activation', with: ''
  click_button 'Create Bomb'
  fill_in 'armingcode', with: '1234'
end

Given(/^A bomb is active and armed$/) do
  visit '/boot/'
  create_and_arm_bomb
  click_button('Arm Bomb')
end

When(/^I apply the disarming code "([^"]*)"$/) do |code|
  fill_in 'disarmingcode', with: code
  click_button 'Disarm Bomb'
end

Then(/^The bomb should deactivate$/) do
  expect(page).to have_text('Bomb Armed :false ')
end

And(/^An incorrect disarming code (\d+) was entered (\d+) times since the bomb was activated$$/) do |code, count|
  count.to_i.times do
    fill_in 'disarmingcode', with: code
    click_button 'Disarm Bomb'
  end
end

Then(/^The see a message that should say deactivation failed$/) do
  expect(page).to have_text('Last deactivation attempt was successful :false')
end

Then(/^The see a message that should say deactivation was successful$/) do
  expect(page).to have_text('Last deactivation attempt was successful :true')
end

Then(/^I see that I have (\d+) attempts left$/) do |number|
  expect(page).to have_text('Deactivation Attempts Left :' << number.to_s)
end

Then(/^The bomb should not explode$/) do
  expect(page).to have_text('Bomb Exploded :false')
end

Then(/^The bomb should explode$/) do
  expect(page).to have_text('Bomb Exploded :true')
end
