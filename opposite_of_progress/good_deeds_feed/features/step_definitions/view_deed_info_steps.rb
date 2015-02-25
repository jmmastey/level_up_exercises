Given(/^a good deed exists$/) do
  FactoryGirl.create(:good_deed)
end

Given(/^I am at a good deed's page$/) do
  visit('/good_deeds/1')
end

Then(/^I see the deed's details$/) do
  expect(page).to have_selector(".good_deed_info")
end

Then(/^I see a link to the deed's sponsor$/) do
  expect(page).to have_selector("#sponsor_link")
end

Then(/^I see a link to search Wikipedia for the deed$/) do
  expect(page).to have_selector("#wiki_link")
end