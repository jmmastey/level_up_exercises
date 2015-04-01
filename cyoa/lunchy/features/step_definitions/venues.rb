When(/^I visit the venues page$/) do
  visit("/venues")
end

Then(/^I should see a venue entry$/) do
  expect(page).to have_css("a.venue-link")
end

Given(/^(\d+) venues exist$/) do |num|
  create_venue(num.to_i)
end

Then(/^I should see (\d+) venue entries$/) do |num|
  entries = all("a.venue-link")
  expect(entries.length).to eq(num.to_i) 
end
