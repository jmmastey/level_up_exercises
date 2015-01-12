Given(/^there are some bills$/) do
  Bill.paginates_per(2)
  FactoryGirl.create_list(:bill, 2)
end

When(/^I visit bills page$/) do
  visit('/bills')
end

Then(/^I should see a list of bills$/) do
  expect(page).to have_content(Bill.first.official_title)
  expect(page).to have_content(Bill.last.official_title)
end

Given(/^there are some bills to exceed the page size$/) do
  Bill.paginates_per(1)
  FactoryGirl.create_list(:bill, 2)
end

Then(/^I should see a paginated list of bills$/) do
  expect(page).to have_content(Bill.first.official_title)
  expect(page).not_to have_content(Bill.last.official_title)
end

Then(/^I should see previously hidden bills$/) do
  expect(page).not_to have_content(Bill.last.official_title)
end
