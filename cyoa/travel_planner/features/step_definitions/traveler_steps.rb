Given(/^that I entered my travel needs$/) do
  visit home_page
  
  fill_in "Meeting Date", with: 2.days.from_now
  fill_in "Meeting Time", with: 2.hours.from_now
  fill_in "Meeting Length", with: 1.5
  fill_in "Origin Airport", with: "ORD"
  fill_in "Destination Airport", with: "LGA"
end

When(/^I click find shortest travel time$/) do
  click_button "Find shortest trip"
end

Then(/^I should see flight options$/) do
  assert page.has_content?("flight options")
end