Given(/^many legislators exist$/) do
  FactoryGirl.create_list(:legislator, 60)
end

Given(/^I am at the "(.*?)" page$/) do |page|
  visit("/#{page}/")
end

Then(/^I see the first page of legislators$/) do
  expect(page).to have_selector(".legislators_index")
end

Then(/^I see pagination links for the list of legislators$/) do
  expect(page).to have_selector(".pagination")
end

Then(/^I see links to filter by party$/) do
  expect(page).to have_selector("#party_filters")
end

Given(/^I navigate to the next page of legislators$/) do
  visit("/legislators/index?page=2")
end

Given(/^I click on a legislator$/) do
  first(:css, "#legislator").click
end

Then(/^I am taken to the legislator info page for that legislators$/) do
  expect(page).to have_selector(".legislator_info")
end
