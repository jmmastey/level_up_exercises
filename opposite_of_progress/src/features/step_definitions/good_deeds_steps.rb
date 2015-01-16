### Givens
Given(/^there are some good deeds$/) do
  GoodDeed.paginates_per(2)
  FactoryGirl.create_list(:good_deed, 1)
  FactoryGirl.create(:good_deed_with_legislator)
end

Given(/^there are some good deeds to exceed the page size$/) do
 GoodDeed.paginates_per(1)
 FactoryGirl.create(:good_deed, acted_at: '2013-01-22')
 FactoryGirl.create(:good_deed, acted_at: '2014-01-22')
end

### Whens
When(/^I visit good deeds page$/) do
  visit('/good_deeds')
end

### Thens
Then(/^I should see a list of good deeds$/) do
  good_deeds = GoodDeed.order(acted_at: :desc).all

  good_deeds.length.times do |i|
    expect(page).to have_content(good_deeds[i].bill.official_title)
  end

  expect(page).to have_content(good_deeds.last.legislator.name)
end

Then(/^I should see a paginated list of good deeds$/) do
  good_deeds = GoodDeed.order(acted_at: :desc).all
  expect(page).to have_content(good_deeds[0].bill.official_title)
  expect(page).not_to have_content(good_deeds[1].bill.official_title)
end

Then(/^I should see previously hidden good deeds$/) do
  good_deed = GoodDeed.order(acted_at: :desc).last
  expect(page).to have_content(good_deed.bill.official_title)
end
