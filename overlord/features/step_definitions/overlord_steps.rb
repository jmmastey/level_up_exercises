Given(/^I have not yet setup the bomb$/) do
end

When(/^I access the bomb interface$/) do
  visit "/"
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I should see an activation code field$/) do
  expect(page).to have_field("activation_code")
end

Then(/^I should see a deactivation code field$/) do
  expect(page).to have_field("deactivation_code")
end

Given(/^I have accessed the bomb interface$/) do
  visit "/"
end

When(/^I enter the activation code$/) do
  fill_in "activation_code", with: "1234"
end

When(/^I enter the deactivation code$/) do
  fill_in "deactivation_code", with: "0000"
end

When(/^I submit the setup information$/) do
  click_button "Save"
end

Given(/^I have setup the bomb$/) do
  visit "/"
  fill_in "activation_code", with: "1234"
  fill_in "deactivation_code", with: "0000"
  click_button "Save"
end

When(/^I activate the bomb with the correct code$/) do
  fill_in "activation_code", with: "1234"
  click_button "Activate"
end

When(/^I activate the bomb with an incorrect code$/) do
  fill_in "activation_code", with: "4321"
  click_button "Activate"
end

Given(/^I have an activated bomb$/) do
  visit "/"
  fill_in "activation_code", with: "1234"
  fill_in "deactivation_code", with: "0000"
  click_button "Save"
  fill_in "activation_code", with: "1234"
  click_button "Activate" 
end

When(/^I enter the correct deactivation code$/) do
  fill_in "deactivation_code", with: "0000"
  click_button "Deactivate"
end

When(/^I enter the incorrect deactivation code$/) do
  fill_in "deactivation_code", with: "9999"
  click_button "Deactivate"
end

When(/^I enter the incorrect deactivation code too many times$/) do
  3.times do
    fill_in "deactivation_code", with: "9999"
    click_button "Deactivate"
  end
end

Given(/^I have setup the bomb with defaults$/) do
  visit "/"
  click_button "Save"
end

When(/^I activate the bomb with the default code$/) do
  fill_in "activation_code", with: "1234"
  click_button "Activate"
end

Given(/^I have an activated bomb setup with defaults$/) do
  visit "/"
  click_button "Save"
  fill_in "activation_code", with: "1234"
  click_button "Activate"
end

When(/^I enter the default deactivate code$/) do
  fill_in "deactivation_code", with: "0000"
  click_button "Deactivate"
end

When(/^I enter an invalid activation code$/) do
  fill_in "activation_code", with: "abcd"
end

When(/^I enter an invalid deactivation code$/) do
  fill_in "deactivation_code", with: "abcd"
end