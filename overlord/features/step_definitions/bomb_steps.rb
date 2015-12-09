
require 'capybara/cucumber'
require 'capybara'

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.configure do |config|
  config.run_server = false
  config.app_host = "localhost:4567"
end

Given(/^the bomb page is loaded$/) do
  visit('/bomb')
end

Then(/^it is not activated$/) do
  expect(page).to have_content("inactive")
  click_button "newbomb"
end

When(/^I input the default activation code$/) do
  fill_in "activation_input", :with => "1234"
  click_button 'submit'
end

And(/^the bomb is now active$/) do
  expect(page).to(have_content("active")) && expect(page).not_to(have_content("inactive"))
end

Then(/^the bomb is active$/) do
  expect(page).to(have_content("active")) && expect(page).not_to(have_content("inactive"))
  click_button "newbomb"
end

Given(/^the bomb page is loaded with specified$/) do
  visit('/newbomb/1444/1111')
end

When(/^I input the specified activation code$/) do
  fill_in "activation_input", :with => "1444"
  click_button 'submit'
end

When(/^I input the wrong code$/) do
  fill_in "activation_input", :with => "1"
  click_button 'submit'
end

Given(/^the bomb page is loaded with non numeric$/) do
  visit('/newbomb/1aaa/1111')
end

Then(/^I get an error$/) do
  expect(page).to have_content("error")
end

When(/^I input the default deactivation code$/) do
  fill_in "deactivation_input", :with => "0000"
  click_button 'submit'
end

When(/^I input the specified deactivation code$/) do
  fill_in "deactivation_input", :with => "1111"
  click_button 'submit'
end

When(/^I input an incorrect deactivation code$/) do
  fill_in "deactivation_input", :with => "1"
  click_button 'submit'
end

Then(/^the number of attempts remaining is (\d+)$/) do |arg1|
  expect(page).to have_content("Failed deactivations: #{3 - arg1.to_i} of 3")
  click_button "newbomb"
end

Then(/^the bomb explodes$/) do
  expect(page).to have_content("exploded")
end