require_relative 'step_helpers'

Given /^I sign in and have showings in my list$/ do
  create_events
  create_user
  add_showings_to_user
  user_signs_in
end

When /^I remove a showing from my personal list$/ do
  @removed_showing = first_showing('Party B')
  click_link(remove_link_id_via_user(@removed_showing))
end

When /^they click on the all-events link$/ do
  click_link('session-bar-events')
end

Then /^I see my showings$/ do
  expect(page).to have_link(add_cal_link(first_showing('Party A')))
  expect(page).to have_link(add_cal_link(first_showing('Party B')))
  expect(page).to have_link(add_cal_link(first_showing('Party C')))
end

Then /^I no longer see that showing in my list$/ do
  expect(page).to     have_link(add_cal_link(first_showing('Party A')))
  expect(page).not_to have_link(add_cal_link(@removed_showing))
  expect(page).to     have_link(add_cal_link(first_showing('Party C')))
end

def first_showing(event_name)
  find_event(event_name).showings[0]
end

def add_cal_link(showing)
  "add_cal-#{showing.id}"
end
