require File.join(File.dirname(__FILE__), '..', 'support/traveler_helpers.rb')

World TravelerHelpers

def fill_in_travel_needs
  visit "trips/new"

  fill_in_datetime_select("meeting_start", 2.days.from_now)
  fill_in "length", with: 1.5
  fill_in "origin_airport", with: "ORD"
  fill_in "destination_airport", with: "LGA"
end

def see_trip_requirements
  expect(page).to have_text("Home location: 10000 W O'Hare Ave, Chicago, IL 60666")
  expect(page).to have_text("Meeting location: LaGuardia Airport, New York, NY 11371")
  expect(page).to have_text("Meeting time: ")
  expect(page).to have_text("Meeting length: 1.5 hours")
end

def see_trip_flights
  # AA #392 departs ORD at 2014-12-22 13:30:00 UTC Arrives LGA at 2014-12-22 15:30:00 UTC
  expect(page).to have_text(/\w{2} #\d+ departs ORD at /)
  expect(page).to have_text(/\w{2} #\d+ departs LGA at /)
end

Given(/^I am not yet using the application$/) do
  #NOOP
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
  expect(page).to have_text(text)
end

Then(/^I should see the shortest trip$/) do
  expect(page).to have_text("Shortest flight options for your trip")
  expect(page).to have_text("Departing flight to LGA")
  expect(page).to have_text("Returning flight to ORD")
end

Then(/^I should see trip requirements$/) do
  see_trip_requirements
end

Then(/^I should see alternate flight options$/) do
  expect(page).to have_text("Alternate flight options")
  expect(page).to have_text("Departure options")
  expect(page).to have_text("Return options")
end

Given(/^that I am viewing the shortest flights$/) do
  fill_in_travel_needs
  click_button("Find shortest trip")
  see_trip_requirements
end

Then(/^I should see a trip summary$/) do
  see_trip_requirements
  see_trip_flights
end

When(/^I select the default flights$/) do
  find(:xpath, "(//input[@name='departure'])[1]").set(true)
  find(:xpath, "(//input[@name='return'])[1]").set(true)
end