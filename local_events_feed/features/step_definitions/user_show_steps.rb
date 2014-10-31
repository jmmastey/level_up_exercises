require_relative 'step_helpers'

Given /^a signed-in user that has showings in their list$/ do
  create_events
  create_user
  add_showings_to_user
  user_signs_in
end

When /^they click on remove for a showing$/ do
  @removed_showing = first_showing('Party B')
  click_link(remove_link_id_user_show(@removed_showing))
end

When /^they click on the all-events link$/ do
  click_link('session-bar-events')
end

Then /^they see their showings on their page$/ do
  expect(page).to have_link(add_cal_link(first_showing('Party A')))
  expect(page).to have_link(add_cal_link(first_showing('Party B')))
  expect(page).to have_link(add_cal_link(first_showing('Party C')))
end

Then /^they no longer see that showing in their list$/ do
  expect(page).to     have_link(add_cal_link(first_showing('Party A')))
  expect(page).not_to have_link(add_cal_link(@removed_showing))
  expect(page).to     have_link(add_cal_link(first_showing('Party C')))
end

Then /^they see the events page$/ do
  expect(page).to have_content('All Events')
end

def first_showing(event_name)
  find_event(event_name).showings[0]
end

def add_cal_link(showing)
  "add_cal-#{showing.id}"
end
