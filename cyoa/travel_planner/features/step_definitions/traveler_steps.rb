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

Then(/^I should see the shortest trip$/) do
  assert_text("Shortest flight options for your trip")
  assert_text("Departing flight to LGA")
  assert_text("Returning flight to ORD")
end

And(/^I should see trip requirements$/) do
  assert_text("Home location: 10000 W O'Hare Ave, Chicago, IL 60666")
  assert_text("Meeting location: LaGuardia Airport, New York, NY 11371")
  assert_text("Meeting time: ")
  assert_text("Meeting length: 1.5 hours")
end