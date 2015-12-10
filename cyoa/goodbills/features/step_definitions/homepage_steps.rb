Given(/^I am on the home page$/) do
  visit('/')
end

Then(/^I should see some bills$/) do
  expect(page).to have_content("test bill 1")
end

When(/^I click the next page button$/) do
  find('Next Page').click
end

Then(/^I should see different bills$/) do
  expect(page).to have_content("test bill 11")
end

Then(/^bills should include voting results$/) do
  expect(page).to have_content("vote up")
end