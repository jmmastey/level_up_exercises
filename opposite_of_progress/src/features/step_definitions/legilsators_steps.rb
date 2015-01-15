def find_legislators
  Legislator.order(chamber: :desc, last_name: :asc)
end

### Givens
Given /^there are few legislators$/ do
  FactoryGirl.create_list(:legislator, Legislator.default_per_page)
end

Given /^there are additional legislators to exceed the page size$/ do
  FactoryGirl.create(:legislator)
end

Given(/^a legislator exists$/) do
  @legislator = FactoryGirl.create(:legislator, state: 'IL')
end

Given(/^legislator has previous sponsoships and cosponsorships$/) do
  @sponsoships = FactoryGirl.create_list(
    :good_deed_with_legislator,
    2,
    legislator: @legislator,
    action: "sponsored"
  )

  @cosponsoships = FactoryGirl.create_list(
    :good_deed_with_legislator,
    3,
    legislator: @legislator,
    action: "cosponsored"
  )
end

Given(/^I have a legislator from the state of Illinois$/) do
  @legislator_illinois = Legislator.first
  @legislator_illinois.update(state: 'IL')
end

Given(/^I have a legislator from the state of Indiana$/) do
  @legislator_indiana = Legislator.last
  @legislator_indiana.update(state: 'IN')
end

Given /^I am on that legislator's page$/ do
  visit("legislators/#{@legislator.id}")
end

Given /^I am on legislators page$/ do
  visit('/legislators')
end

### Whens
When(/^I click on legislator's name$/) do
  @legislator = find_legislators().first
  click_link(@legislator.name)
end

When /^I visit that legislator's page$/ do
  visit("legislators/#{@legislator.id}")
end

When /^I visit legislators page$/ do
  visit('/legislators')
end

When(/^I select Illinois as state$/) do
  select('Illinois', from: 'state-select')
end

### Thens
Then /^I should see the legislator list$/ do
  legislators = find_legislators
  first = legislators.first
  last = legislators.last

  expect(Legislator.count).to eq(2)
  expect(page).to have_content(first.name)
  expect(page).to have_content(last.name)
end

Then /^I should see paginated legislator list$/ do
  legislators = find_legislators
  first = legislators.first
  last = legislators.last

  expect(Legislator.count).to be(3)
  expect(page).to have_content(first.name)
  expect(page).not_to have_content(last.name)
end

Then /^I should see previously hidden legislators$/ do
  last = find_legislators().last
  expect(page).to have_content(last.name)
end

Then(/^I should see that legislator's page$/) do
  assert_path("/legislators/#{@legislator.id}")
end

Then(/^I see the details about that legislator$/) do
  expect(page).to have_content(@legislator.title)
  expect(page).to have_content(@legislator.name)
  expect(page).to have_content("Illinois")
end

Then(/^I see the picture of that legislator$/) do
  pending "still we do not have real data"
  image = find(:css, '.legislator-image img')
  expect(image['src']).to match("#{@legislator.bioguide_id}.jpg")
end

Then(/^I should see cosponsorships$/) do
  expect(page).to have_content('Sponsorships')
  expect(page).to have_css('.sponsorships .good-deed', count: 2)
end

Then(/^I should see sponsorships$/) do
  expect(page).to have_content('Co-sponsorships')
  expect(page).to have_css('.cosponsorships .good-deed', count: 3)
end

Then(/^I should see legislator from Illinois$/) do
  expect(page).to have_content(@legislator_illinois.name)
end

Then(/^I should not see legislator from Indiana$/) do
  expect(page).not_to have_content(@legislator_indiana.name)
end

Then(/^I should not see favorite buttons$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see favorite buttons$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I favorite a legislator$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see that legislator favorited$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I have favorited the legislator$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I unfavorite one of legislator$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see that legislator unfavorited$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not see favorite button$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see favorite button$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I favorite that legislator$/) do
  pending # express the regexp above with the code you wish you had
end
