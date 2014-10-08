require 'timecop'
require 'time'

Given(/^the bomb is activated with code "(.*?)"$/) do |code|
  visit("/")
  fill_in("Code", with: code)
  click_button("Enter")
end

When(/^I wait (\d+) seconds$/) do |offset|
  Timecop.travel(Time.now + offset.to_i)
end
