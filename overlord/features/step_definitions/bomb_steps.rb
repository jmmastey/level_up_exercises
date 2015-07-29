ACTIVATION_DEFAULT = "1234"
DEACTIVATION_DEFAULT = "0000"

GET_CODE_INFO = /(?:| with (.*) code "(\d*)")/
GET_TIMER = /(?:| with timer at "(\d\d:\d\d:\d\d)")/

Given(/^I have not configured my bomb$/) do
  visit path_to("my bomb")
end

Given(/^a new bomb$/) do
  visit path_to("my bomb")
  step "I submit code \"\""
  step "I submit code \"\""
end

Given(/^a bomb configured with codes "([^"]*)" and "([^"]*)"$/) do |arg1, arg2|
  visit path_to("my bomb")
  step "I submit code \"arg1\""
  step "I submit code \"arg2\""
end

Given(/^an activation code selection "([^"]*)"$/) do |code|
  visit path_to("my bomb")
  step "I submit code \"#{code}\""
end

Given(/^an inactive bomb#{GET_CODE_INFO}#{GET_TIMER}$/) do |type, code, time|
  act_code = type == "activation" ? code : ACTIVATION_DEFAULT
  deact_code = type == "deactivation" ? code : DEACTIVATION_DEFAULT
  step "a bomb configured with codes \"#{act_code}\" and \"#{deact_code}\""
  fill_in("top secret countdown setter", with: time) unless time.nil?
end

Given(/^an active bomb#{GET_CODE_INFO}#{GET_TIMER}$/) do |type, code, time|
  set_code_info = type && code ? " with #{type} code \"#{code}\"" : ""
  set_timer = time ? " with timer at \"#{time}\"" : ""
  step "an inactive bomb#{set_code_info}#{set_timer}"
  act_code = type == "activation" ? code : ACTIVATION_DEFAULT
  step "I activate the bomb with \"#{act_code}\""
end

Given(/^an exploded bomb$/) do
  step "an active bomb"
  step "I submit 3 bad codes"
end

When(/^.* submits? code "(.*)"$/) do |value|
  fill_in("code", with: value)
  click_button("Submit")
end

When(/^.* submits? (\d+) bad codes$/) do |count|
  count.to_i.times do
    fill_in("code", with: "bad")
    click_button("Submit")
  end
end

When(/^I submit (\d+) bad (de)?activation codes$/) do |count, is_deactivation|
  step "I submit code \"\"" if is_deactivation
  step "I submit #{count} bad codes"
end

When(/activates? the bomb(?:| with "(.*)")(?:| (\d+) times)$/) do |code, count|
  code ||= ACTIVATION_DEFAULT
  count ||= 1
  count.to_i.times do
    fill_in("code", with: code)
    click_button("Submit")
    click_button("Confirm")
  end
end

When(/^I cut the wires$/) do
  click_button("Wires")
end

Then(/^the bomb is active$/) do
  step "the \"status\" field should contain \"active\""
end

Then(/^the bomb is inactive$/) do
  step "the \"status\" field should contain \"inactive\""
end

Then(/^the bomb is( not)? exploded$/) do |negation|
  if negation
    step "I should see \"Control Panel\""
  else
    step "there is nothing but a pile of rubble"
  end
end

Then(/^the bomb is disabled$/) do
  step "I should not see \"Configuration Panel\""
  step "I should not see \"Control Panel\""
  step "I should see \"Damaged!\""
end

Then(/^I need to confirm activation$/) do
  step "I should see \"Please confirm activation.\""
  step "the \"status\" field should contain \"inactive\""
end

Then(/^(".*") is "red"$/) do |button|
  expect(find_button(button).background).to eq("Red")
end

Then(/^(".*") is "big"$/) do |button|
  expect(find_button(button).padding).to be > 35
end

Then(/^he should see "([^"]*)"$/) do |arg1|
  step "I should see \"#{arg1}\""
end

Then(/^there is nothing but a pile of rubble$/) do
  step "I should not see \"Configuration Panel\""
  step "I should not see \"Control Panel\""
  step "I should not see \"Access Panel\""
  step "I should see \"You are surrounded by rubble.\""
end
