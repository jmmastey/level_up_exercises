ACTIVATION_DEFAULT = "1234"
DEACTIVATION_DEFAULT = "0000"

GET_CODE_INFO = /(?:| with (.*) code "(.*)")/
GET_ACTIVATION_CODE = /(?:| with activation code "(.*)")/
GET_TIMER = /(?:| with timer at "(\d\d:\d\d:\d\d)")/

Given(/^I am ready to enact my evil plan$/) do
end

Given(/^a newly constructed bomb$/) do
  bomb = Bomb.new
end

Given(/^a newly booted bomb#{GET_ACTIVATION_CODE}$/) do |code_value|
  step "a newly constructed bomb"
  bomb.boot!
  activation_code = code_value || ACTIVATION_DEFAULT
  fill_in("code", with: activation_code)
end

Given(/^an inactive bomb#{GET_CODE_INFO}#{GET_TIMER}$/) do |type, code, time|
  activation_code = type == "activation" ? code : ACTIVATION_DEFAULT
  deactivation_code = type == "deactivation" ? code : DEACTIVATION_DEFAULT
  step "a newly booted bomb with activation code \"#{activation_code}\""
  fill_in("code", with: deactivation_code)
  bomb.set_timer(time) unless time.nil?
end

Given(/^an active bomb#{GET_CODE_INFO}#{GET_TIMER}$/) do |type, code, time|
  set_code_info = " with #{type} code \"#{code}\""
  set_timer = " with timer at \"#{time}\""
  step "an inactive bomb#{set_code_info}#{set_timer}"
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

When(/activates? the bomb(?:| with "(.*)")(?:| (\d+) times)$/) do |code, count|
  code ||= ACTIVATION_DEFAULT
  count ||= 1
  count.to_i.times do
    fill_in("code", with: code)
    click_button("Confirm")
  end
end

When(/^.* fills? in "(.*)" with (\d+) bad codes$/) do |field, count|
  count.to_i.times fill_in(field, with: "bad")
end

When(/^.* fills in "(.*)" with "(.*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I wait (\d+) seconds$/) do |delay|
  bomb.advance_time!(delay)
end

When(/^I cut the wires$/) do
  bomb.cut_wires!
end

When(/^an explosion is triggered$/) do
  bomb.explode!
end

Then(/^the bomb is active$/) do
  expect(bomb).to be_active
end

Then(/^the bomb is inactive$/) do
  expect(bomb).not_to be_active
end

Then(/^the bomb is( not)? exploded$/) do |negation|
  if negation
    expect(bomb).not_to be_exploded
  else
    expect(bomb).to be_exploded
  end
end

Then(/^the bomb is disabled$/) do
  expect(bomb).to be_disabled
end

Then(/^(".*") is "big"$/) do |button|
  expect(find_button(button).background).to eq("Red")
end

Then(/^(".*") is "red"$/) do |button|
  expect(find_button(button).padding).to be > 35
end

Then(/^the activation code is "(.*)"$/) do |code_value|
  expect(bomb.activation_code).to eq?(code_value)
end

Then(/^the deactivation code is "(.*)"$/) do |code_value|
  expect(bomb.deactivation_code).to eq?(code_value)
end

Then(/^I need to confirm activation$/) do
  step "I see \"Please confirm activation.\""
  expect(bomb).not_to be_active
end

Then(/^he should see "([^"]*)"$/) do |arg1|
  step "I should see \"#{arg1}\""
end

Then(/^there is nothing but a pile of rubble$/) do
  step "I should not see \"Control Panel\""
  step "I should see \"You are surrounded by rubble.\""
end

Then(/(\d*) seconds? later (.*)/) do |delay, action|
  bomb.advance_time!(delay)
  step action
end

Then(/^the "([^"]*)" field stops at "([^"]*)"$/) do |field_name, value|
  step "the #{field_name} field contains #{value}"
  bomb.advance_time!(5)
  step "the #{field_name} field contains #{value}"
end
