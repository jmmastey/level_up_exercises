def create_items(items_params)
  @items = items_params.map do |item_param|
    FactoryGirl.create(:item, item_param)
  end
end

def find_item(in_game_id)
  @items.select { |item| item.in_game_id == in_game_id }.first
end

Given(/^I have the following items:$/) do |items|
  create_items(items.hashes)
end

When(/^I visit the items page$/) do
  visit "/items"
end

When(/^I click the "([^"]+)" link for item #(\d+)$/) do |link_text, in_game_id|
  item = find_item(in_game_id.to_i)
  within("#item-#{item.id}") do
    click_link(link_text)
  end
end

Then(/^I see (\d+) items$/) do |count|
  expect(page).to have_css("tr.item", count: count)
end

Then(/^I see (\d+) in the EVE ID column$/) do |id|
  expect(page).to have_css("tr.item td.field-in_game_id",
                           text: id.to_s)
end

Then(/^I see "([^"]+)" in the name column$/) do |name|
  expect(page).to have_css("tr.item td.field-name",
                           text: name)
end
