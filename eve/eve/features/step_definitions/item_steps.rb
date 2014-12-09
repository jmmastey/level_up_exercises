Given(/^I have the following items:$/) do |items|
  items.hashes.each do |item|
    FactoryGirl.create(:item, item)
  end
end

When(/^I visit the items page$/) do
  visit "/items"
end

Then(/^I should see (\d+) items$/) do |count|
  expect(page).to have_css("tr.item", count: count)
end

Then(/^I should see (\d+) in the EVE ID column$/) do |id|
  expect(page).to have_css("tr.item td.field-in_game_id",
                           text: id.to_s)
end

Then(/^I should see "([^"]+)" in the name column$/) do |name|
  expect(page).to have_css("tr.item td.field-name",
                           text: name)
end
