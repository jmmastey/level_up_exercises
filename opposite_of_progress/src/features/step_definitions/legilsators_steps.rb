def find_legislators
  Legislator.order(chamber: :desc, last_name: :asc)
end

Given /^there are few legislators$/ do
  FactoryGirl.create_list(:legislator, Legislator.default_per_page)
end

Then /^I should see the legislator list$/ do
  legislators = find_legislators
  first = legislators.first
  last = legislators.last

  expect(Legislator.count).to eq(2)
  expect(page).to have_content(first.name)
  expect(page).to have_content(last.name)
end

Given /^there are additional legislators to exceed the page size$/ do
  FactoryGirl.create(:legislator)
end

Then /^I should see paginated legislator list$/ do
  legislators = find_legislators
  first = legislators.first
  last = legislators.last

  expect(Legislator.count).to be(3)
  expect(page).to have_content(first.name)
  expect(page).not_to have_content(last.name)
end

Then /^When I click on the next pagination link$/ do
  within('.pagination') do
    click_link('Next')
  end
end

Then /^I should see previously hidden legislators$/ do
  last = find_legislators().last
  expect(page).to have_content(last.name)
end

When(/^I click on legsilator's name$/) do
  @legislator = find_legislators().first
  click_link(@legislator.name)
end

Then(/^I should see that legislator's page$/) do
  assert_path("/legislators/#{@legislator.id}")
end
