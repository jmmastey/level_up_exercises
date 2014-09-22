# Given #
Given(/^I leave activation and deactivation code fields blank$/) do
  visit('/')
  fill_in("activation_code", with: "")
  fill_in("deactivation_code", with: "")
end

Given(/^I enter custom activation and deactivation codes "(.*?)" "(.*?)"$/) do |code_act, code_deact|
  visit('/')
  fill_in("activation_code", with: code_act)
  #fill_in("deactivation_code", with: code_deact)
  fill_in("Deactivation Code", with: code_deact)
end

Given(/^I have booted a bomb with default codes$/) do
  @bomb = Bomb.new
end

Given(/^I have booted a bomb with custom codes (\d+) (\d+)$/) do |act_code, deact_code|
  @bomb = Bomb.new(act_code, deact_code)
end

# When #
When(/^I press boot$/) do
  click_button("Boot")
end

When(/^I activate it with (\d+)$/) do |code|
  @bomb.activate(code)
end

When(/^I deactivate it with (\d+)$/) do |code|
  @bomb.deactivate(code)
end

# Then #
Then(/^there should be a field to activate the bomb$/) do
  page.should have_content("activate-btn")
end

Then(/^there should be a field to deactivate the bomb$/) do
  page.should have_content("deactivate-btn")
end

Then(/^I should stay on the page$/) do
  pending # express the regexp above with the code you wish you had
end
