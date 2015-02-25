Given(/^a legislator exists$/) do
  FactoryGirl.create(:legislator)
end

When(/^I visit that legislator's page$/) do
  visit('/legislators/1')
end

Then(/^I should see the legislator's details$/) do
  expect(page).to have_selector(".legislator_info")
end

Then(/^I should see a list of their good deeds$/) do
  expect(page).to have_selector(".legislators_good_deeds")
end