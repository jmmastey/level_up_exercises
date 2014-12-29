require_relative 'step_helpers'

Given /^there are some events not on my list$/ do
  create_more_events
end

Given /^I visit the events page$/ do
  visit(events_path)
end

Given /^No events exist in the database$/ do
  Event.all.each(&:destroy)
end

When /^I scrape for events$/ do
  click_link("Scrape")
end

When /^I click on an event$/ do
  click_link("#{Event.first.name}-events")
end

Then /^I am on the events page$/ do
  expect(page).to have_content('All Events')
end

Then /^I see my events highlighted$/ do
  expect(page).to have_selector(:css, '.member')
end

Then /^I see non-highlighted events$/ do
  expect(page).to have_selector(:css, '.non-member')
end

Then /^I see events on the page$/ do
  expect(page).to have_selector(:css, "td")
end

Then /^I do not see events on the page$/ do
  expect(page).not_to have_selector(:css, "td")
end

Then /^I see the details for that event$/ do
  expect(page).to have_content(Event.first.name)
  expect(page).to have_link('Website')
end
