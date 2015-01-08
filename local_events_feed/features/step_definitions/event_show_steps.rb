Given /^I visit the event page for one of my shows$/ do
  visit(events_path)
  click_link("#{user_events.first.name}-events")
end

When /^I remove one of my showings from the event's list$/ do
  @removed_showing = a_user_showing
  click_link(remove_link_id_via_event(a_user_showing))
end

When /^I add a showing from the event's list$/ do
  @added_showing = a_non_user_showing
  click_link(add_link_id(a_non_user_showing))
end

Then /^I have the option to add the removed showing back to my list$/ do
  expect(page).to have_link(add_link_id(@removed_showing))
end

Then /^I have the option to remove the added showing$/ do
  expect(page).to have_link(remove_link_id_via_event(@added_showing))
end

