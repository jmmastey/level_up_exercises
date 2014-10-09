require_relative 'step_helpers'

Given /^a signed-in user that has events in their list$/ do
  add_events_to_user
  user_signs_in
end

When /^they click on remove for an event$/ do
  click_link("remove-#{find_event('Party B').id}")
end

When /^they click on the all-events link$/ do
  click_link("Browse All Events")
end

Then /^they should see their events on their page$/ do
  expect(page).to have_content('Party A')
  expect(page).to have_content('Party B')
  expect(page).to have_content('Party C')
end

Then /^they should no longer see that event in their list$/ do
  expect(page).to have_content('Party A')
  expect(page).to have_content('Party C')
end

Then /^they should see the events page$/ do
  expect(page).to have_content('All Events')
end
