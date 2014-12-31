Given(/^a bomb has been activated$/) do
  visit('/')
  create_bomb(create_activation_code: 1111,
              create_deactivation_code: 2222,
              create_fuse: 10)
  activate_bomb(activation_code: 1111)
end

When(/^I deactivate the bomb$/) do
  deactivate_bomb(deactivation_code: 2222)
end

Then(/^I should be able to reactivate the bomb$/) do
  activate_bomb(activation_code: 1111)
  expect(current_path).to eq("/bomb/active")
  expect(page).to have_content("Bomb Status: ACTIVE")
end

When(/^I try to deactivate the bomb incorrectly$/) do
  deactivate_bomb(deactivation_code: "wrong")
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
