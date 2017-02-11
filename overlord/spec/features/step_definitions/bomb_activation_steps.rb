require 'capybara/cucumber' 
require 'Pry'
require 'httpi'
require_relative "../../spec_helper.rb"
Given(/^a new bomb presented to super villian$/) do
  page.visit '/'  
  get_bomb_data
end

When(/^([a-z]+[-]*[a-z]+) ([a-z]+) code is entered$/) do |validity_type, code_type|
  find_code_to_enter_and_submit(validity_type, code_type)
end

Then(/^bomb state is ([a-z]*)$/) do |status|
  page.should have_content("Bomb State is #{status}")
end

Then(/^error "([^"]*)" is displayed to user$/) do |arg1|
  page.driver.alert_messages[0].should == ("Please enter numeric codes only!")
end

Given(/^a active bomb presented to super villian$/) do
  visit '/'
  get_bomb_data
  find_code_to_enter_and_submit('correct', 'activation')
end

Given(/^a active bomb presented to super villian with (\d+) unsuccessful deactivation attempts$/) do |count|
  visit '/'
  get_bomb_data
  find_code_to_enter_and_submit('correct', 'activation')
  count.to_i.times do 
    find_code_to_enter_and_submit('incorrect', 'deactivation')
  end
end

Then(/^nothing is visible$/) do
  page.has_button?('Deactivate').should == false
  page.has_field?('deactivation_code').should == false
end

def get_bomb_data
  request = HTTPI::Request.new
  request.url = "http://localhost:4567/fetch_bomb_codes"
  response = HTTPI.get(request)
  response = JSON.parse(response.body)
  @activation_code = response["activation_code"]
  @deactivation_code = response["deactivation_code"]
  @state = response["state"]
end

def find_code_to_enter_and_submit(validity_type, code_type)
  activation = (code_type == 'activation') ? true : false
  code = case validity_type
    when 'correct'
      activation ? @activation_code : @deactivation_code 
    when 'incorrect'
      (((activation ? @activation_code : @deactivation_code).to_i + 1)%10000).to_s
    when 'non-numeric'
      'abcd'
  end
  enter_code_and_submit(code)
end

def enter_code_and_submit(code)
  if(page.has_button?('Deactivate'))
    page.fill_in 'deactivation_code', :with => code
    page.click_button 'Deactivate'
  elsif(page.has_button?('Activate'))
    page.fill_in 'activation_code', :with => code
    page.click_button 'Activate'
  end
end
