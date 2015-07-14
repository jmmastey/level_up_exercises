require 'selenium-webdriver'
require 'pry'
driver = Selenium::WebDriver.for :firefox

Given /^the user presses reset$/ do
  binding.pry
  reset_button = driver.find_element(:id => "bomb_reset_btn")
  reset_button.click
end

Given /^the user is on the home page$/ do
  visit "/"
end

Then /^the user should see the bomb state$/ do
  browser.div(:class => "bomb_state").exists?
end
