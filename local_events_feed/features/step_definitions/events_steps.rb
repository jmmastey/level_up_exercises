require_relative 'step_helpers'

Given /^there are other events not on their list$/ do
  create_more_events
end

Given /^they are on the events page$/ do
  visit(events_path)
end

When /^they click on the remove-link next to an event$/ do
  @removed_event = a_user_event
  click_link(remove_link_id(a_user_event))
end

When /^they click on the add-link next to an event$/ do
  @added_event = a_non_user_event
  click_link(add_link_id(a_non_user_event))
end

When /^they click on scrape-events$/ do
  click_link("Scrape for Events")
end

Then /^they should see an remove-link next to each of their events$/ do
  user_events.each do |event|
    expect(page).to have_link(remove_link_id(event))
  end
end

Then /^they see an add-link next to each event that is not in their events$/ do
  non_user_events.each do |event|
    expect(page).to have_link(add_link_id(event))
  end
end

Then /^the removed event will have an add-link next to it$/ do
  expect(page).to have_link(add_link_id(@removed_event))
end

Then /^the added event will have a remove-link next to it$/ do
  expect(page).to have_link(remove_link_id(@added_event))
end

Then /^there should be events on the page$/ do
  expect(page).to have_link(add_link_id(Event.first))
end

Then /^there should be no events on the page$/ do
  expect(page).not_to have_selector(:css, "td")
end
