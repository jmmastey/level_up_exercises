require_relative '../../bomb'

Given /I create a bomb with no code/ do
  @bomb = Bomb.new
end

Given /I create a bomb with codes ([^\s]+) and ([^\s]+)/ do |act_code, deact_code|
  @bomb = Bomb.new(act_code, deact_code)
end

Given /an activated bomb with default codes/ do
  @bomb = Bomb.new
  @bomb.activate('1234')
end

When /I activate it with code ([^\s]+)/ do |code|
  @bomb.activate(code)
end

When /I deactivate it with code ([^\s]+)/ do |code|
  @bomb.deactivate(code)
end

When /I deactivate it with bad code ([^\s]+)/ do |code|
  expect { @bomb.deactivate(code) }.to raise_error(ArgumentError)
end

When /I snip the wires/ do
  @bomb.snip
end

When /I detonate it/ do
  @bomb.detonate
end



Then /I should see it is active/ do
  expect(@bomb).to be_active
  expect(@bomb).not_to be_exploded
end

Then /I should see it is not active/ do
  expect(@bomb).not_to be_active
  expect(@bomb).not_to be_exploded
end

Then /I should see it exploded/ do
  expect(@bomb).to be_exploded
end

Then /I should see it not exploded/ do
  expect(@bomb).not_to be_exploded
end

Then /I should see status "(.*?)" \+ "(.*?)" \+ (\d) deactivation attempts/ do |integrity, activation, attempts|
  expect(@bomb.to_h["integrity"]).to eq(integrity)
  expect(@bomb.to_h["activation"]).to eq(activation)
  expect(@bomb.to_h["deact_attempts"]).to eq(attempts.to_i)
end

