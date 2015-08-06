Given(/^I have an armed bomb ready to disarm$/) do
  arm_bomb_with_default
  visit 'disarm_bomb'
end

Then(/^I should not see "([^"]*)"$/) do |arg1|
  expect(page).to_not have_content(arg1)
end
