def search(search_term)
  fill_in 'search', with: search_term
  find('[name=commit]').click
end

Given(/^I am on search page$/) do
  visit('/search')
end

# Following steps should be updated appropriately if legislators for 60005
# changes. (i.e congress change, resignation, demise etc.)

Given(/^all legislators for zip code 60056 exist$/) do
  FactoryGirl.create(
    :representative,
    first_name: 'Tammy',
    last_name: 'Duckworth',
    middle_name: nil,
    bioguide_id: 'D000622',
    state: 'IL'
  )

  FactoryGirl.create(
    :representative,
    first_name: 'Janice',
    last_name: 'Schakowsky',
    middle_name: 'D',
    bioguide_id: 'S001145',
    state: 'IL'
  )

  FactoryGirl.create(
    :representative,
    first_name: 'Bob',
    last_name: 'Dold',
    middle_name: nil,
    bioguide_id: 'D000613',
    state: 'IL'
  )

  FactoryGirl.create(
    :senator,
    first_name: 'Mark',
    last_name: 'Kirk',
    middle_name: 'S',
    bioguide_id: 'K000360',
    state: 'IL'
  )

  FactoryGirl.create(
    :senator,
    first_name: 'Richard',
    last_name: 'Durbin',
    middle_name: 'J',
    bioguide_id: 'D000563',
    state: 'IL'
  )

  Legislator.paginates_per(5)
end

When(/^I search legislators for 60056$/) do
  search('60056')
end

Then(/^I should see all legislators for 60056$/) do
  expect(page).to have_content('Richard J. Durbin')
  expect(page).to have_content('Mark S. Kirk')
  expect(page).to have_content('Tammy Duckworth')
  expect(page).to have_content('Janice D. Schakowsky')
  expect(page).to have_content('Bob Dold')
end

When(/^I search by address in 60056$/) do
  search('415 W Enterprise Dr Mount Prospect IL 60056')
end

Then(/^I should see all legislators for that address$/) do
  expect(page).to have_content('Richard J. Durbin')
  expect(page).to have_content('Mark S. Kirk')
  expect(page).to have_content('Tammy Duckworth')
  expect(page).not_to have_content('Janice D. Schakowsky')
  expect(page).not_to have_content('Bob Dold')
end
