Given /^they are on the event page for one of their shows$/ do
  visit(events_path)
  click_link("#{user_events.first.name}-events")
end

When /^they click on the remove-link next to a showing$/ do
  @removed_showing = a_user_showing
  click_link(remove_link_id_event_show(a_user_showing))
end

When /^they click on the add-link next to a showing$/ do
  @added_showing = a_non_user_showing
  click_link(add_link_id(a_non_user_showing))
end

Then /^they can remove showings already in their list$/ do
  user_events.first.showings.each do |showing|
    if showing.in?(@user.showings)
      expect(page).to have_link(remove_link_id_event_show(showing))
    end
  end
end

Then /^they can add showings not already in their list$/ do
  user_events.first.showings.each do |showing|
    if !showing.in?(@user.showings)
      expect(page).to have_link(add_link_id(showing))
    end
  end
end

Then /^the removed showing will have an add-link next to it$/ do
  expect(page).to have_link(add_link_id(@removed_showing))
end

Then /^the added showing will have a remove-link next to it$/ do
  expect(page).to have_link(remove_link_id_event_show(@added_showing))
end

