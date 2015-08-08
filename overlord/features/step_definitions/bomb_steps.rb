ACTIVATION_TEST_DEFAULT = "1234"
DEACTIVATION_TEST_DEFAULT = "0000"
GET_CODE_INFO = /(?:| with (.*) code "(\d*)")/

Given(/^I have not configured my bomb$/) do
  visit path_to("my bomb")
end

Given(/^an activation code selection "([^"]*)"$/) do |code|
  visit path_to("my bomb")
  step "I submit code \"#{code}\""
end

Given(/^a bomb configured with codes "(.*)" and "(.*)"$/) do |code1, code2|
  visit path_to("my bomb")
  step "I submit code \"#{code1}\""
  step "I submit code \"#{code2}\""
end

Given(/^a new bomb$/) do
  step "a bomb configured with codes \"1234\" and \"0000\""
end

Given(/^an inactive bomb#{GET_CODE_INFO}$/) do |type, code|
  act_code = type == "activation" ? code : ACTIVATION_TEST_DEFAULT
  deact_code = type == "deactivation" ? code : DEACTIVATION_TEST_DEFAULT
  step "a bomb configured with codes \"#{act_code}\" and \"#{deact_code}\""
end

Given(/^an active bomb#{GET_CODE_INFO}$/) do |type, code|
  act_code = type == "activation" ? code : ACTIVATION_TEST_DEFAULT
  deact_code = type == "deactivation" ? code : DEACTIVATION_TEST_DEFAULT
  step "a bomb configured with codes \"#{act_code}\" and \"#{deact_code}\""
  step "I activate the bomb with \"#{act_code}\""
end

Given(/^an exploded bomb$/) do
  step "an active bomb"
  step "I submit 3 bad codes"
end

When(/^(?:|I )go to (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^(?:|I )press "([^\"]*)"$/) do |button|
  click_button(button)
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
  code ||= ACTIVATION_TEST_DEFAULT
  fill_in("code", with: code)
  click_button("Submit")
  click_button("Confirm")
end

When(/^I cut the wires$/) do
  click_button("Wires")
end

Then(/^(?:|I )(?:|he )should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^(?:|I )should not see "([^\"]*)"$/) do |text|
  expect(page).to have_no_content(text)
end

Then(/^the status field should contain "(.*)"$/) do |value|
  field = find_field("status")
  expect(field.value =~ /#{value}/).to eq(0)
end

Then(/^the bomb is active$/) do
  step "the status field should contain \"^active$\""
end

Then(/^the bomb is inactive$/) do
  step "the status field should contain \"^inactive$\""
end

Then(/x^the bomb is( not)? exploded$/) do |negation|
  if negation
    expect(page).to have_content("Control Panel")
  else
    step "there is nothing but a pile of rubble"
  end
end

Then(/^the bomb is exploded$/) do
  step "there is nothing but a pile of rubble"
end

Then(/^the bomb is obviously disabled$/) do
  expect(page).to have_no_content("Configuration Panel")
  expect(page).to have_no_content("Control Panel")
  expect(page).to have_content("Damaged!")
end

Then(/^I need to confirm activation with the BigRedButton$/) do
  expect(page).to have_content("Please confirm activation.")
  step "the status field should contain \"inactive\""
  expect(find_button("BigRedButton"))
end

Then(/^there is nothing but a pile of rubble$/) do
  expect(page).to have_no_content("Configuration Panel")
  expect(page).to have_no_content("Control Panel")
  expect(page).to have_no_content("Access Panel")
  expect(page).to have_content("You are surround by rubble.")
end
