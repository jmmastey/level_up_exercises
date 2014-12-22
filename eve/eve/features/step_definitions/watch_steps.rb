WATCH_ASSOCIATION_CLASSES = {
  "item" => Item,
  "region" => Region,
  "station" => Station
}

def create_watches
  @watches = [FactoryGirl.create(:watch, :with_nickname, user: default_user),
              FactoryGirl.create(:watch,
                                 :filter_by_region,
                                 user: default_user),
              FactoryGirl.create(:watch,
                                 :with_nickname,
                                 :filter_by_station,
                                 user: default_user)]
end

def set_watch_association(type, association_name)
  association_class = WATCH_ASSOCIATION_CLASSES[type]
  association = association_class.find_by(name: association_name)
  page.find("input#watch_#{type}_id").set(association.id.to_s)
end

Given(/^I am on the new watch page$/) do
  visit new_watch_path
end

Given(/^some watches exist$/) do
  create_watches
end

When(/^I visit the watches page$/) do
  visit watches_path
end

When(/^I visit the new watch page$/) do
  visit new_watch_path
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

Then(/^I see the details of those watches$/) do
  @watches.each do |watch|
    expect(page).to have_css(".watch#watch-#{watch.id}")
    expect(page).to have_content(watch.nickname)
    expect(page).to have_content(watch.item.try(:name))
    expect(page).to have_content(watch.region.try(:name))
    expect(page).to have_content(watch.station.try(:name))
  end
end
