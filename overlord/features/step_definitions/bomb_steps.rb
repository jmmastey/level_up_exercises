Given /^I visit bomb boot setup page$/ do
  visit 'http://localhost:4567'
end

When /^I fill in '(.*)' for '(.*)'$/ do |activation_code, textfield|
  fill_in textfield, :with => activation_code
end

Given /^I fill in '(.*)' to activate my bomb$/ do |activate_code|
  fill_in 'act_code', :with => activate_code
  click_button 'Activate my bomb!'
end

When /^I fill in '(.*)' to deactivate my bomb$/ do |deactivate_code|
  fill_in 'deact_code', :with => deactivate_code
  click_button 'Deactivate now!'
end

Then /^I should see '(.*)'$/ do |text|
  expect(page.text).to have_content(/#{text}/)
end

Then /^I should remain on boom boot page$/ do
  expect(current_url).to eq("http://localhost:4567/")
end

Given /^I activate the bomb$/ do
  fill_in 'act_code', :with => '1234'
  click_button 'Activate my bomb!'
end 

Given /^I configure codes to '(.*)' and '(.*)'$/ do |activation_code, deactivation_code|
  code_config(activation_code, deactivation_code)
end

Given /^I dont configure codes$/ do
  default_config
end

When /^I enter the activation code wrong three times$/ do
  (1..3).each do |i|
    fill_in 'act_code', :with => '2341'
    click_button 'Activate my bomb!'
    click_button 'Go Back'
  end
  fill_in 'act_code', :with => '3289'
  click_button 'Activate my bomb!'
end
