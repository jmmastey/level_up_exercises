Given(/^I have booted the bomb with default codes$/) do
  visit("/")
  click_button("Boot")
end

Given(/^I have booted the bomb with custom codes (\d+) (\d+)$/) do |act_code, deact_code|
  visit("/")
  fill_in("activation_code", with: act_code)
  fill_in("deactivation_code", with: deact_code)
  click_button("Boot")
end

When(/^I activate it with (\d+)$/) do |code|
  fill_in("code", with: code)
  click_button("Activate")
end

When(/^I deactivate it with (\d+)$/) do |code|
  fill_in("code", with: code)
  click_button("Deactivate")
end
