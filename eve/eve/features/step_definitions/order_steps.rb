def create_items_for_orders
  @items = FactoryGirl.create_list(:item, 3)
end

def create_locations_for_orders
  @regions = FactoryGirl.create_list(:region, 3)
  @stations = FactoryGirl.create_list(:station, 9)
end

def create_orders
  params = [
    { item: @items[0], region: @regions[0], station: @stations[0] },
    { item: @items[0], region: @regions[1], station: @stations[4] },
    { item: @items[1], region: @regions[0], station: @stations[1] },
    { item: @items[0], region: @regions[0], station: @stations[2] }
  ]
  params.each { |param| FactoryGirl.create(:order, param) }
end

Given(/^some orders exist$/) do
  create_items_for_orders
  create_locations_for_orders
  create_orders
end

When(/^I visit the orders page$/) do
  visit "/orders"
end

When(/^I search for orders without expected matches$/) do
  find("#item").set(@items[1].id)
  find("#region").set(@regions[2].id)
  find("button[type='submit']").click
end

When(/^I search for orders with expected matches$/) do
  find("#item").set(@items[0].id)
  find("#region").set(@regions[0].id)
  find("button[type='submit']").click
end

Then(/^I see the details of those orders$/) do
  expect(page).to have_selector("tr.order", count: 4)
end

Then(/^I see the details of matching orders$/) do
  expect(page).to have_selector("tr.order", count: 2)
end
