def create_orders
  FactoryGirl.create_list(:order, 10)
end

Given(/^some orders exist$/) do
  create_orders
end

When(/^I visit the orders page$/) do
  visit "/orders"
end

Then(/^I see the details of those orders$/) do
  expect(page).to have_selector("tr.order", count: 10)
end
