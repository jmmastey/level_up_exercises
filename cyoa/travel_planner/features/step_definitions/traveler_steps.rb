require File.join(File.dirname(__FILE__), '..', 'support/traveler_helpers.rb')

World TravelerHelpers

def fill_in_travel_needs
  visit "trips/new"

  fill_in_datetime_select("meeting_start", 2.days.from_now)
  fill_in "length", with: 1.5
  fill_in "origin_airport", with: "ORD"
  fill_in "destination_airport", with: "LGA"
end

def assert_see_trip_reqs
  assert_text("Home location: 10000 W O'Hare Ave, Chicago, IL 60666")
  assert_text("Meeting location: LaGuardia Airport, New York, NY 11371")
  assert_text("Meeting time: ")
  assert_text("Meeting length: 1.5 hours")
end

Given(/^I am not yet using the application$/) do
end

When(/^I go to the home page$/) do
  visit "/"
end

When(/^I click "([^"]*)"$/) do |text|
  click_button(text)
end

Given(/^that I entered my travel needs$/) do
  fill_in_travel_needs
end

Then(/^I should see "([^"]*)"$/) do |text|
  assert_text(text)
end

Then(/^I should see the shortest trip$/) do
  assert_text("Shortest flight options for your trip")
  assert_text("Departing flight to LGA")
  assert_text("Returning flight to ORD")
  # TODO: require flight number
end

And(/^I should see trip requirements$/) do
  assert_see_trip_reqs
end

And(/^I should see alternate flight options$/) do
  assert_text("Alternate flight options")
  assert_text("Departure options")
  assert_text("Return options")
end

Given(/^that I am viewing the shortest flights$/) do
  fill_in_travel_needs
  click_button("Find shortest trip")
  assert_see_trip_reqs
end

Then(/^I should see a trip summary$/) do
  pending
end
