def create_items(items_params)
  @items = items_params.map do |item_param|
    FactoryGirl.create(:item, item_param)
  end
end

def find_item(in_game_id)
  @items.select { |item| item.in_game_id == in_game_id }.first
end

def search_box
  find("input#query")
end

Given(/^I have the following items:$/) do |items|
  create_items(items.hashes)
end

Given(/^I am on the items page$/) do
  visit items_path
end

When(/^I visit the items page$/) do
  visit items_path
end

When(/^I search for "([^"]+)"$/) do |term|
  search_box.set(term)
  find("button[title='Search']").click
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

Then(/^I see the orders page for item #(\d+)$/) do |in_game_id|
  item = find_item(in_game_id.to_i)
  expect(current_path_with_query).to eq(search_orders_path(item: item))
end

Then(/^I see "([^"]+)" in the search box$/) do |term|
  expect(search_box.value).to eq(term)
end
