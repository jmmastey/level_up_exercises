require './spec/spec_helper.rb'
include OverlordTest

Given(/^I have an activated bomb$/) do
  Given I have booted the bomb
  And I have configured the bomb
  And I have entered the right activation configured
  And the status indicator shows as activated
end
