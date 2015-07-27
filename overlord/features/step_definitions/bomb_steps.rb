ACTIVATION_DEFAULT = "1234"
DEACTIVATION_DEFAULT = "0000"

Given(/^I am ready to enact my evil plan$/) do
end

Given(/^a newly constructed bomb$/) do
  bomb = Bomb.new
end

Given(/^a newly booted bomb(?:| with activation code "(.*)")$/) do |code_value|
  step "a newly constructed bomb"
  bomb.boot!
  activation_code = code_value || ACTIVATION_DEFAULT
  fill_in("code", with: activation_code)
end

Given(/^an inactive bomb(?:| with (.*) code "(.*)")(?:| with timer at "(\d\d:\d\d:\d\d)")$/) do |type, code_value, time|
  activation_code = type == "activation" ? code_value : ACTIVATION_DEFAULT
  deactivation_code = type == "deactivation" ? code_value : DEACTIVATION_DEFAULT
  step "a newly booted bomb with activation code \"#{activation_code}\""
  fill_in("code", with: deactivation_code)
  bomb.set_timer(time) unless time.nil?
end

Given(/^an active bomb(?:| with (.*) code "(.*)")(?:| with timer at "(\d\d:\d\d:\d\d)")$/) do |type, code_value, time|
  step "an inactive bomb with #{type} code \"#{code_value}\" with timer at \"#{time}\""
  step "I activate the bomb"
end

Given(/^an exploded bomb$/) do
  step "an active bomb"
  bomb.explode!
end

Given(/^a disabled active bomb$/) do
  step "an active bomb"
  bomb.disable!
end

Given(/^a bomb waiting for confirmation of activation$/) do
  step "an active bomb"
  fill_in("code", with: ACTIVATION_DEFAULT)
end

When(/^I configure the codes$/) do
  click_button("Boot")
  fill_in("code", with: ACTIVATION_DEFAULT)
  fill_in("code", with: DEACTIVATION_DEFAULT)
end

When(/^.* activates? the bomb(?:| with "(.*)")(?:| "(\d+)" times)$/) do |code_value, number|
  code_value = code_value || ACTIVATION_DEFAULT
  number = 1 if number.nil?
  number.to_i.times do
    fill_in("code", with: code_value)
    click_button("Confirm")
  end
end

When(/^.* fills? in "(.*)" with (\d+) bad codes$/) do |field, number|
  number.to_i.times fill_in(field, with: "bad")
end

When(/^.* fills in "(.*)" with "(.*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I wait (\d+) seconds$/) do |number|
  bomb.advance_time!(number)
end

When(/^I cut the wires$/) do
  bomb.cut_wires!
end

When(/^an explosion is triggered$/) do
  bomb.explode!
end

Then(/^the bomb is (.*)$/) do |status|
  expect(bomb.status).to be status.to_sym
end

Then(/^the activation code is "(.*)"$/) do |code_value|
  expect(bomb.activation_code).to eq?(code_value)
end

Then(/^the deactivation code is "(.*)"$/) do |code_value|
  expect(bomb.deactivation_code).to eq?(code_value)
end

Then(/^I need to confirm activation$/) do
  step "I see \"Please confirm activation.\""
  expect(bomb.status).to be :inactive
end

Then(/^he should see "([^"]*)"$/) do |arg1|
  step "I should see \"#{arg1}\""
end

Then(/^there is nothing but a pile of rubble$/) do
  step "I should not see \"Control Panel\""
  step "I should see \"You are surrounded by rubble.\""
end

Then(/(\d*) seconds? later (.*)/) do |delay, action|
  bomb.advance_time(delay)
  step action
end

Then(/^the "([^"]*)" field stops at "([^"]*)"$/) do |field_name, value|
  step "the #{field_name} field contains #{value}"
  bomb.advance_time(5)
  step "the #{field_name} field contains #{value}"
end
