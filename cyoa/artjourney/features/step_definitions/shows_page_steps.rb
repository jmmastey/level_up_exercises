Given(/^some shows$/) do
  FactoryGirl.create_list :show, 5
end

When(/^I visit the shows page$/) do
  visit '/shows'
end

Then(/^I should see show names$/) do
  expect(page).to have_content 'Show-1'
  expect(page).to have_content 'Show-2'
  expect(page).to have_content 'Show-3'
  expect(page).to have_content 'Show-4'
  expect(page).to have_content 'Show-5'
end
