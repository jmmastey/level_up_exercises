Given(/^many good deeds exist$/) do
  FactoryGirl.create_list(:good_deed, 60)
end

Given(/^I am at the good deeds page$/) do
visit('/good_deeds')
end

Then(/^I see the first page of good deeds$/) do
  expect(page).to have_selector(".good_deeds_index")
end

Then(/^I see pagination links for the list of good deeds$/) do
  expect(page).to have_selector(".pagination")
end

#Then(/^I see links to filter by party$/) do
#  pending # express the regexp above with the code you wish you had
#end

Given(/^I navigate to the next page of good deeds$/) do
  visit("/good_deeds/index?page=2")
end

Then(/^I am taken to the second page of good deeds$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I click on a good deed$/) do
  first(:css, "#good_deed").click
end

Then(/^I am taken to the deed details page for that good deed$/) do
  expect(page).to have_selector(".good_deed_info")
end
