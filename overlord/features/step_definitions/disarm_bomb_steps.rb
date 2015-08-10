Given(/^I have an armed bomb ready to disarm$/) do
  arm_bomb_for_disarming
end

Then(/^I should not see "([^"]*)"$/) do |arg1|
  expect(page).to_not have_content(arg1)
end

When(/^I enter (\d+) for "([^"]*)"$/) do |value, field|
  fill_in(field, with: value)
end

When(/^I enter the wrong code three times$/) do
  arm_bomb_for_disarming
  disarm_bomb_second_try
end
