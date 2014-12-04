Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I click on (.+)$/) do |item|
  click_link(item)
end

Then(/^I should see a link to the (.+) page$/) do |name|
  expect(page).to have_selector('a', text: name)
end

Then(/^a (.+) button$/) do |name|
  expect(page).to have_selector('a', text: name)
end

Then(/^I should be on the (.+) page$/) do |name|
  expect(page).to have_selector('h1', text: name)
end
