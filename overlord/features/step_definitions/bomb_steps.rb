require_relative '../../bomb'

Given /I create a bomb with default codes/ do
  @respond = Respond.new('bomb_responses.json')
  @bomb = Bomb.new(@respond)
end

Given /I create a bomb with codes ([^\s]+) and ([^\s]+)/ do |act_code, deact_code|
  respond = Respond.new('bomb_responses.json')
  @bomb = Bomb.new(respond, act_code, deact_code)
end

Given /an activated bomb with default codes/ do
  respond = Respond.new('bomb_responses.json')
  @bomb = Bomb.new(respond)
  @bomb.activate('1234')
end

Given /I activate the bomb$/ do
  @bomb.activate('1234')
end

Given /I deactivate the bomb$/ do
  @bomb.deactivate('0000')
end

When /I unsuccessfully deactivate it (\d+) time/ do |attempts|
  attempts.to_i.times { @bomb.deactivate('1111') }
end

When /I activate it with code ([^\s]+)$/ do |code|
  @bomb.activate(code)
end

When /I deactivate it with code ([^\s]+)$/ do |code|
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

Then /I should see status: Integrity => "(.*?)", Activation => "(.*?)", Attempts => (\d+)/ do |integrity, activation, attempts|
  expect(@bomb.to_h["integrity"]).to eq(integrity)
  expect(@bomb.to_h["activation"]).to eq(activation)
  expect(@bomb.to_h["deact_attempts"]).to eq(attempts.to_i)
end

Then /it should respond with "(.*?)"/ do |response|
  expect(@respond.last).to eq(response)
end
