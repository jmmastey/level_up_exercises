# ACTIVATION_DEFAULT and DEACTIVATION_DEFAULT are set in overlord.rb

GET_CODE_INFO = /(?:| with (.*) code "(\d*)")/

Given(/^I have not configured my bomb$/) do
  visit path_to("my bomb")
end

Given(/^an activation code selection "([^"]*)"$/) do |code|
  visit path_to("my bomb")
  step "I submit code \"#{code}\""
end

Given(/^a bomb configured with codes "([^"]*)" and "([^"]*)"$/) do |arg1, arg2|
  visit path_to("my bomb")
  step "I submit code \"#{arg1}\""
  step "I submit code \"#{arg2}\""
end

Given(/^a new bomb$/) do
  step "a bomb configured with codes \"1234\" and \"0000\""
end

Given(/^an inactive bomb#{GET_CODE_INFO}$/) do |type, code|
  act_code = type == "activation" ? code : ACTIVATION_DEFAULT
  deact_code = type == "deactivation" ? code : DEACTIVATION_DEFAULT
  step "a bomb configured with codes \"#{act_code}\" and \"#{deact_code}\""
end

Given(/^an active bomb#{GET_CODE_INFO}$/) do |type, code|
  act_code = type == "activation" ? code : ACTIVATION_DEFAULT
  deact_code = type == "deactivation" ? code : DEACTIVATION_DEFAULT
  step "a bomb configured with codes \"#{act_code}\" and \"#{deact_code}\""
  step "I activate the bomb with \"#{act_code}\""
end

Given(/^an exploded bomb$/) do
  step "an active bomb"
  step "I submit 3 bad codes"
end

When(/^.* submits? code "(.*)"(?:| (\d+) times)$/) do |value, count|
  count ||= 1
  count.to_i.times do
    fill_in("code", with: value)
    click_button("Submit")
  end
end

When(/^.* submits? (\d+) bad codes$/) do |count|
  count.to_i.times do
    fill_in("code", with: "bad")
    click_button("Submit")
  end
end

When(/activates? the bomb(?:| with "(.*)")$/) do |code|
  code ||= ACTIVATION_DEFAULT
  fill_in("code", with: code)
  click_button("Submit")
  click_button("Confirm")
end

When(/^I cut the wires$/) do
  click_button("Wires")
end

Then(/^the bomb is active$/) do
  step "the \"status\" field should contain \"^active$\""
end

Then(/^the bomb is inactive$/) do
  step "the \"status\" field should contain \"^inactive$\""
end

Then(/x^the bomb is( not)? exploded$/) do |negation|
  if negation
    step "I should see \"Control Panel\""
  else
    step "there is nothing but a pile of rubble"
  end
end

Then(/^the bomb is exploded$/) do
  step "there is nothing but a pile of rubble"
end

Then(/^the bomb is disabled$/) do
  step "I should not see \"Configuration Panel\""
  step "I should not see \"Control Panel\""
  step "I should see \"Damaged!\""
end

Then(/^I need to confirm activation with the BigRedButton$/) do
  step "I should see \"Please confirm activation.\""
  step "the \"status\" field should contain \"inactive\""
  expect(find_button("BigRedButton"))
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
