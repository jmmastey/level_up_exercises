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

When /^the user submits (.*)code (\d+)$/ do |type, code|
  field_id = ""
  case type
  when "deactivation "
    field_id = "deactivation_key"
  when "activation "
    field_id = "activation_key"
  when ""
    field_id = "submit_code"
  else
    raise "Invalid Submission Type"
  end
  region = browser.find_element(id: field_id)
  region.find_element(class: "textbox").send_keys(code)
  region.find_element(class: "button").click
end

Then /^the user should see the bomb state$/ do
  browser.find_elements(:id => "bomb_state").any?.should eq(true)
end

Then /^the bomb state is valid$/ do
  element = browser.find_element(:id => "bomb_state")
  bomb_states.should include(element.text)
end

Then /^the (.*) code will be (\d+)$/ do |type, code|
  region = browser.find_element(id: type+"_key")
  region.find_element(class: "status").text.should eq(code)
end

Then /^the user should see the time$/ do
  browser.find_elements(:id => "timer").any?.should eq(true)
end

Then /^the time is (.*)$/ do |time|
  browser.find_element(:id => "timer").text.should eq(time)
end

Then /^the bomb is (.*)$/ do |state|
  if state == "booted"
    element = browser.find_element(:id => "bomb_state")
    booted_states.should include(element.text)
  else
    browser.find_element(:id => "bomb_state").text.should eq(state)
  end
end
