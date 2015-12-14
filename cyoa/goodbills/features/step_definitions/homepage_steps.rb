Given(/^some more bills$/) do
  FactoryGirl.create_list :bill, 20
end

Given(/^I am on the home page$/) do
  visit('/')
end

Then(/^I should see some bills$/) do
  expect(page).to have_content("title-")
  @content = page.html
end

Then(/^I should see a next page button$/) do
  expect(page).to have_content("Next Page")
end

Then(/^I should not see a previous page button$/) do
  expect(page).not_to have_content("Previous Page")
end

Then(/^I should see a previous page button$/) do
  expect(page).to have_content("Previous Page")
end

When(/^I click the next page button$/) do
  click_button('Next Page')
end

Then(/^I should see different bills$/) do
  expect(page.html).not_to eq(@content)
  expect(page).to have_content("Current Page: 2")
end

Then(/^bills should include voting results$/) do
  expect(page).to have_content("Score")
end
