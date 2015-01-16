require './spec/spec_helper.rb'
include OverlordTest

DEFAULT_ACTIVATION_CODE = "1234"
DEFAULT_DEACTIVATION_CODE = "0000"

When(/^I enter the code "(.*?)" (\d+) time\(s\)$/) do |code, times|
  (1..times.to_i).each do
	  fill_in "code", with: code
	  click_button "submit"
	end
end

When(/^I enter the default activation code (\d+) time\(s\)$/) do |times|
  (1..times.to_i).each do
	  fill_in "code", with: DEFAULT_ACTIVATION_CODE
	  click_button "submit"
	end
end

When(/^I enter the default deactivation code (\d+) time\(s\)$/) do |times|
  (1..times.to_i).each do
	  fill_in "code", with: DEFAULT_DEACTIVATION_CODE
	  click_button "submit"
	end
end