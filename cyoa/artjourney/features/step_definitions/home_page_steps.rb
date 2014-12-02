Given(/^some shows$/) do
  FactoryGirl.create_list :shows, 5
end

When(/^I visit the home page$/) do
  visit '/'
end

Then(/^I should see shows$/) do
  expect(page).to have_content 'Show 1'
  expect(page).to have_content 'Show 2'
  expect(page).to have_content 'Show 3'
  expect(page).to have_content 'Show 4'
  expect(page).to have_content 'Show 5'
end
