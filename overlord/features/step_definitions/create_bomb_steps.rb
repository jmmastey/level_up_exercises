Given(/^I'm on the homepage$/) do
  visit('/')
end

When(/^I create a bomb with all custom inputs$/) do
  create_bomb(create_activation_code: 1234,
              create_deactivation_code: 1234,
              create_fuse: 5)
end

# ================================================

# This might be a flapping test
When(/^I create a bomb with no activation or deactivation code$/) do
  create_bomb
end

When(/^I create a bomb with only an activation code$/) do
  create_bomb(create_activation_code: 1111)
end

When(/^I create a bomb with only a deactivation code$/) do
  create_bomb(create_deactivation_code: 222)
end

When(/^I create a bomb with only a fuse$/) do
  create_bomb(create_fuse: 5)
end

Then(/^the bomb status should be Inactive$/) do
  expect(page).to have_content("Bomb Status: Inactive")
end

Then(/^I should still see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
