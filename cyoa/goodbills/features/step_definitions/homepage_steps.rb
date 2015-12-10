Given(/^some more bills$/) do
  FactoryGirl.create_list :bill, 20
end

Given(/^I am on the home page$/) do
  visit('/')  
end

Then(/^I should see some bills$/) do
  expect(page).to have_content("title-1")
end

When(/^I click the next page button$/) do
  click_button('Next Page')
end

Then(/^I should see different bills$/) do
  expect(page).not_to have_content("title-1")
end

Then(/^bills should include voting results$/) do
  expect(page).to have_content("vote up")
end