Given(/^a legislator exists$/) do
  FactoryGirl.create(:legislator)
end

When(/^I visit that legislator's page$/) do
  visit('/legislators/1')
end

Then(/^I should see the legislator's details$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see a list of their good deeds$/) do
  pending # express the regexp above with the code you wish you had
end