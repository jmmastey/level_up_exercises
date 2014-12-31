Given(/^a bomb has been created with (\d+), (\d+), (\d+) as inputs$/) do |arg1, arg2, arg3|
  visit('/')
  create_bomb(create_activation_code: arg1,
              create_deactivation_code: arg2,
              create_fuse: arg3)
end

Given(/^I'm on the inactive bomb page$/) do
  expect(current_path).to eq("/bomb/inactive")
end

When(/^I activate a bomb with (\d+)$/) do |arg1|
  activate_bomb(activation_code: arg1)
end

When(/^I activate a bomb with "(.*?)"$/) do |arg1|
  activate_bomb(activation_code: arg1)
end

Then(/^I expect to be warned that the bomb is "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
