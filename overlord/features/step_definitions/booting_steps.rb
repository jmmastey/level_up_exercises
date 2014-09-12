When(/^I boot a bomb$/) do
  @bomb = Bomb.new
end

Then(/^the bomb should not be activated$/) do
  expect(@bomb).not_to be_active
end

Then(/^its activation code should be (\d+)$/) do |code|
  expect(@bomb.activation_code).to eq(code)
end

Then(/^its deactivation code should be (\d+)$/) do |code|
  expect(@bomb.deactivation_code).to eq(code)
end

Given(/^my activation code is (\d+)$/) do |code|
  @activation_code = code
end

Given(/^my deactivation code is (\d+)$/) do |code|
  @deactivation_code = code
end

When(/^I boot a bomb with both codes$/) do
  @bomb = Bomb.new(@activation_code, @deactivation_code)
end
