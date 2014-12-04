Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I click on Artists$/) do
  click_link('Artists')
end

Then(/^I should see a link to the artists page$/) do
  expect(page).to have_selector('a', text: 'Artists')
end

Then(/^a login button$/) do
  expect(page).to have_selector('a', text: 'Login')
end

Then(/^a signup button$/) do
  expect(page).to have_selector('a', text: 'Signup')
end

Then(/^I should be on the artists page$/) do
  expect(page).to have_selector('h1', text: 'Artists')
end
