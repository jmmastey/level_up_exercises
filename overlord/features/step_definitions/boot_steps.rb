require 'pp'

Given(/^I am viewing "([^\"]*)"$/) do |url|
  visit(url)
end

And(/^I click "([^\"]*)"$/) do |button|
  click_button(button)
end

And(/^I enter the "([^"]*)" code ([^"]*)$/) do |name, code|
  fill_in name, with: code
end

And(/^I set the default codes$/) do
  visit('/')
  click_button("BOOT")
end

And(/^I set the custom codes$/) do
  steps %{
    And I enter the "a_code" code 1235
    And I click "BOOT"
  }
end

And(/^I enter the correct default activation code$/) do
  steps %{
      And I enter the "activate" code 1234
      And I click "ACTIVATE"
    }
end

And(/^I enter the correct custom activation code$/) do
  steps %{
      And I enter the "activate" code 1235
      And I click "ACTIVATE"
    }
end

And(/^I enter the wrong default activation code$/) do
  fill_in "activate", with: "1235"
  click_button("ACTIVATE")
end

Then(/^I should (not )?see an element "([^"]*)"$/) do |negate, selector|
  expectation = negate ? :should_not : :should
  page.send(expectation, have_css(selector))
end

Then(/^bomb status is "([^"]*)"$/) do |status|
  bomb_status = ".status-" + status
  page.find(bomb_status).should be_visible
end
