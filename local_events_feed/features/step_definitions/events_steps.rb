require_relative 'step_helpers'

Given /^there are other events not on their list$/ do
  create_more_events
end

Given /^they are on the events page$/ do
  visit(events_path)
end

When /^they click on scrape-events$/ do
  click_link("Scrape")
end

When /^they click on an event$/ do
  click_link("#{Event.first.name}-events")
end

Then /^they see highlighted events$/ do
  expect(page).to have_selector(:css, '.member')
end

Then /^they see non-highlighted events$/ do
  expect(page).to have_selector(:css, '.non-member')
end

Then /^there will be events on the page$/ do
  expect(page).to have_selector(:css, "td")
end

Then /^there will not be events on the page$/ do
  expect(page).not_to have_selector(:css, "td")
end

Then /^they see the event page for that event$/ do
  expect(page).to have_content(Event.first.name)
  expect(page).to have_link('Website')
end
