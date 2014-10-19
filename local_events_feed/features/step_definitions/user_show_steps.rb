require_relative 'step_helpers'

Given /^a signed-in user that has showings in their list$/ do
  create_events
  create_user
  add_showings_to_user
  user_signs_in
end

When /^they click on remove for a showing$/ do
  click_link("remove-#{find_event('Party B').showings[0].id}")
end

When /^they click on the all-events link$/ do
  click_link("Browse All Events")
end

Then /^they see their showings on their page$/ do
  expect(page).to have_content('Party A')
  expect(page).to have_content('Party B')
  expect(page).to have_content('Party C')
end

Then /^they no longer see that showing in their list$/ do
  expect(page).to have_content('Party A')
  expect(page).not_to have_content('Party B')
  expect(page).to have_content('Party C')
end

Then /^they see the events page$/ do
  expect(page).to have_content('All Events')
end
