When(/^I enter the default deactivation code$/) do
  fill_in("deact_code", with: "0000")
  click_button("Submit deactivation code")
end

When(/^I try to deactivate the bomb$/) do
  click_button("Submit deactivation code")
end

When(/^I try to deactivate the bomb with an incorrect code (\d+) times$/) do |number|
  number.to_i.times do
    fill_in("deact_code", with: "9999")
    click_button("Submit deactivation code")
  end
end

When(/^I enter an incorrect deactivation code$/) do
  fill_in("deact_code", with: "9999")
end

Then(/^the bomb is deactivated$/) do
  page.assert_selector(".bomb_deactivated")
end

Then(/^the bomb does not deactivate$/) do
  expect(page).to have_selector(".active_bomb")
end

Then(/^there are (\d+) deactivation attempts remaining$/) do |number|
  expect(page).to have_selector(".attempts_remaining", text: /#{number}/i)
end

Then(/^there is (\d+) deactivation attempt remaining$/) do |number|
  expect(page).to have_selector(".attempts_remaining", text: /#{number}/i)
end
