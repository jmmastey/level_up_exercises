require File.join(File.dirname(__FILE__), '..', 'support/traveler_helpers.rb')

World TravelerHelpers

Given(/^that I entered my travel needs$/) do
  visit "trips/new"

  fill_in_datetime_select("meeting_start", 2.days.from_now)
  fill_in "length", with: 1.5
  fill_in "origin_airport", with: "ORD"
  fill_in "destination_airport", with: "LGA"
end

When(/^I click find shortest travel time$/) do
  click_button "Find shortest trip"
end

Then(/^I should see flight options$/) do
  assert page.has_content?("flight options")
end
