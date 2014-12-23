Given(/^a bomb has been activated$/) do
  visit('/')
  fill_in("create_activation_code", with: 1234)
  fill_in("create_deactivation_code", with: 0000)
  click_button('Create!')
  fill_in "activation_code", with: 1234
  click_button('Activate!')
  # expect(current_path).to eq("/bomb/active")
end

When(/^I deactivate the bomb$/) do
  fill_in "deactivation_code", with: 0000
  click_button('Deactivate!')
  # expect(current_path).to eq("/bomb/inactive")
end

Then(/^I should be able to reactivate the bomb$/) do
  fill_in "activation_code", with: 1234
  click_button('Activate!')
  expect(current_path).to eq("/bomb/active")
  expect(page).to have_content("Bomb Status: ACTIVE")
end

When(/^I try to deactivate the bomb incorrectly$/) do
  fill_in "deactivation_code", with: "wrong"
  click_button('Deactivate!')
  # expect(current_path).to eq("/bomb/active")
end

Then(/^I should be warned that my activation code is incorrect$/) do
  expect(page).to have_content("Incorrect code - ur still gonna blow!")
end

Then(/^I should be warned the number of incorrect attempts$/) do
  expect(page).to have_content("Incorrect Attempts: 1")
end

When(/^I try to deactivate the bomb (\d+) times incorrectly$/) do |arg1|
  arg1.to_i.times do
    fill_in "deactivation_code", with: "wrong"
    click_button('Deactivate!')
  end
end

Then(/^the bomb should explode$/) do
  expect(current_path).to eq("/exploded")
  expect(page).to have_content("Everyone's dead")
end
