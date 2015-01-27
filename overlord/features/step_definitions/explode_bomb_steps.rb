When(/^I enter an incorrect deactivation code (\d+) time\(s\)$/) do |number|
  number.to_i.times do
    fill_in('submitted_deact_code', with: "4444")
    click_button('Submit deactivation code')
  end
end

Then(/^the bomb should explode$/) do
  expect(page).to have_selector('.bomb_exploded')
end