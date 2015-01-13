def get_bills
  Bill.order(last_action_at: :desc)
end

def create_bill
  FactoryGirl.create(:bill, official_title: 'Lorem Ipsum')
end

Given(/^there are some bills$/) do
  Bill.paginates_per(2)
  FactoryGirl.create_list(:bill, 2)
end

Given(/^there is a bill$/) do
  @bill = create_bill
end

When(/^I visit bills page$/) do
  visit('/bills')
end

When(/^I visit that bill's page$/) do
  visit("/bills/#{@bill.id}")
end

When(/^I click on bill's name$/) do
  @bill = get_bills.first
  click_link(@bill.official_title)
end

Then(/^I should see a list of bills$/) do
  bills = get_bills
  expect(page).to have_content(bills.first.official_title)
  expect(page).to have_content(bills.last.official_title)
end

Given(/^there are some bills to exceed the page size$/) do
  Bill.paginates_per(1)
  FactoryGirl.create_list(:bill, 2)
end

Then(/^I should see a paginated list of bills$/) do
  bills = get_bills
  expect(page).to have_content(bills.first.official_title)
  expect(page).not_to have_content(bills.last.official_title)
end

Then(/^I should see previously hidden bills$/) do
  bills = get_bills
  expect(page).to have_content(bills.last.official_title)
end

Then(/^I should see that bill's page$/) do
  assert_path("/bills/#{@bill.id}")
end

Then(/^I see the official title$/) do
  expect(page).to have_content(@bill.official_title)
end

Then(/^the details about the bill$/) do
  expect(page).to have_content(@bill.chamber.capitalize)
  expect(page).to have_content(@bill.summary)
  expect(page).to have_link(@bill.url)
end


Given(/^there is a bill with sponsorship$/) do
  @bill = create_bill
  @good_deeds = FactoryGirl.create_list(:good_deed_with_legislator, 2, bill: @bill, action: 'sponsored')
end

Then(/^I see the sponsorships$/) do
  expect(page).to have_content(@good_deeds[0].legislator.name)
  expect(page).to have_content(@good_deeds[1].legislator.name)
end

Given(/^there is a bill with cosponsorship$/) do
  @bill = create_bill
  @good_deeds = FactoryGirl.create_list(:good_deed_with_legislator, 2, bill: @bill, action: 'cosponsored')
end

Then(/^I see the cosponsorships$/) do
  expect(page).to have_content(@good_deeds[0].legislator.name)
  expect(page).to have_content(@good_deeds[1].legislator.name)
end

Given(/^there is a bill with action$/) do
  @bill = create_bill
  @good_deed = FactoryGirl.create(:good_deed, bill: @bill, action: 'voted', chamber: "House")
end

Then(/^I see the actions$/) do
  expect(page).to have_content("Passed by House")
end
