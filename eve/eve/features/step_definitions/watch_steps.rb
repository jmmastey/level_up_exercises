WATCH_ASSOCIATION_CLASSES = {
  "item" => Item,
  "region" => Region,
  "station" => Station
}

def set_watch_association(type, association_name)
  association_class = WATCH_ASSOCIATION_CLASSES[type]
  association = association_class.find_by(name: association_name)
  page.find("input#watch_#{type}_id").set(association.id.to_s)
end

Given(/^I am on the new watch page$/) do
  visit "/watches/new"
end

When(/^I visit the new watch page$/) do
  visit "/watches/new"
end

When(/^I set the watch nickname to "([^"]*)"$/) do |nickname|
  fill_in "Nickname", with: nickname
end

When(/^I set the watch (item|region|station) to "([^"]*)"$/) do |type, name|
  set_watch_association(type, name) unless name.blank?
end

When(/^I save the watch$/) do
  click_button("Save")
end

Then(/^I see the new watch form$/) do
  expect(page).to have_css("form#new_watch")
end
