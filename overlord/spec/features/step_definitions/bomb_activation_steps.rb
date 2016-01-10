require 'capybara/cucumber' 
require_relative "../../spec_helper.rb"
Given(/^a new bomb presented to super villian$/) do
  @bomb = Bomb.new
  page.visit 'http://google.com'
end

When(/^([a-z]+[-]*[a-z]+) ([a-z]+) code is entered$/) do |validity_type, code_type|
  activation = (code_type == 'activation') ? true : false
  code = case code_type
    when 'correct'
      activation ? @activation_code : @deactivation_code 
    when 'incorrect'
      ((activation ? @activation_code : @deactivation_code) + 1)[0..4]
    when 'non-numeric'
      'abcd'
  end
  page.fill_in 'code', :with => code
end

Then(/^bomb state is ([a-z]*active)$/) do |status|
  status.should == @bomb.status
  page.should_have_content("Bomb is #{status}")
end

Then(/^error "([^"]*)" is displayed to user$/) do |arg1|
  page.should_have_content("arg1")
end

Given(/^a active bomb presented to super villian$/) do
  @bomb = Bomb.new
  @bomb.activate
end
