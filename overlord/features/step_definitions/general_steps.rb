Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

Given(/^a bomb has been created and activated with a (\d+) sec fuse$/) do |arg1|
  visit('/')
  create_bomb(create_activation_code: 1234,
              create_deactivation_code: 0000,
              create_fuse: arg1.to_i)
  activate_bomb(activation_code: 1234)
end

When(/^I wait (\d+) seconds to do something$/) do |arg1|
  # Mock?
  sleep(arg1.to_i)
  click_button('Deactivate!')
end

Then(/^the bomb should have exploded$/) do
  expect(current_path).to eq("/exploded")
  expect(page).to have_content("Everyone's dead")
end

When(/^I deactivate the bomb before (\d+) seconds have passed$/) do |arg1|
  sleep(arg1.to_i - 1)
  fill_in "deactivation_code", with: 0000
  click_button('Deactivate!')
end

Then(/^the bomb should be deactivated$/) do
  expect(page).to have_content("Bomb has been deactivated")
end
