require_relative '../support/helpers.rb'

Given(/^I have inserted "(.*?)" as the activation code$/) do |code|
  fill_activate_code(code)
end

Given(/^the bomb is activated$/) do
  visit path_to('the home page')
  activate(1234)
end
