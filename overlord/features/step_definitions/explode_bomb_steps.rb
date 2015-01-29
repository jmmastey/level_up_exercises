Given(/^the bomb has been booted and activated with the default codes$/) do
  visit("/")
  click_button("Boot bomb")
  fill_in("act_code", with: "1234")
  click_button("Submit activation code")
  expect(page).to have_selector(".deact_code_guess")
end

When(/^I enter an incorrect deactivation code (\d+) time\(s\)$/) do |number|
  number.to_i.times do
    fill_in("deact_code", with: "1111")
    click_button("Submit deactivation code")
  end
end

Then(/^the bomb explodes$/) do
  expect(page).to have_selector(".bomb_exploded")
end
