require 'capybara/cucumber'

Given(/^I am on Amazon homepage$/) do
  visit "http://www.amazon.com"
end
When /^I enter "(.*?)" in the search box$/ do |keywords|
  # search = page.find("Name")
  fill_in "field-keywords", :with => keywords
  # page.save_screenshot('input_keyword.png')
  # Launchy.open 'input_keyword.png'
end
When /^I click "Go" button$/ do
  click_button "Go"
  # page.save_screenshot('click_go.png')
  # Launchy.open 'click_go.png'
end

Then(/^I should see a list of results related with Baseball Gloves$/) do
  expect(page).to have_text("Wilson A360 Baseball Glove")
end