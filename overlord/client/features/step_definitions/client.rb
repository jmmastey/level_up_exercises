require 'selenium-webdriver'
require 'pry'
browser = Selenium::WebDriver.for :firefox

bomb_states = ["off", "active", "inactive", "exploded"]
booted_states = bomb_states.reject { |e| e == "off" }

Given /^the user presses reset$/ do
  reset_button = browser.find_element(:id => "bomb_reset_btn")
  reset_button.click
end

Given /^the user is on the home page$/ do
  visit "/"
  browser.get("http://localhost:1234")
end

When /^the user presses boot bomb$/ do
  boot = browser.find_element(:id => "bomb_boot_btn")
  boot.click
  # Wait for view to update
  sleep(1)
end

Then /^the user should see the bomb state$/ do
  browser.find_elements(:id => "bomb_state").any?.should eq(true)
end

Then /^the bomb state is valid$/ do
  element = browser.find_element(:id => "bomb_state")
  bomb_states.should include(element.text)
end

Then /^the bomb is booted$/ do
  element = browser.find_element(:id => "bomb_state")
  booted_states.should include(element.text)
end
