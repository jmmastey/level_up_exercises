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

### Whens
When(/^I click on legislator's name$/) do
  @legislator = find_legislators().first
  click_link(@legislator.name)
end

When(/^I visit that legislator's page$/) do
  visit("legislators/#{@legislator.id}")
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
