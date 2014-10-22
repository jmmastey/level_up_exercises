require_relative "../bomb"

Given /^the password is (\d+)$/ do |code|
  @bomb = Bomb.new(code.to_i)
end

Given /^the bomb is inactive/ do
  @bomb = Bomb.new
end

When /^I type (\d+)$/ do |code|
  @bomb.enter_code(code.to_i)
end

And /^I press activate/ do
  @bomb.activate
end

Then /^the bomb should be active/ do
 expect(@bomb).to be_active
end

Then /^the bomb should be inactive/ do
 expect(@bomb).not_to be_active
end 

And /^I press deactivate/ do
  @bomb.deactivate
end

Then /^the bomb should explode/ do
  expect(@bomb).to be_exploded
end
