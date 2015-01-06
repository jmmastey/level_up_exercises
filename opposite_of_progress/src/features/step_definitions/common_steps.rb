# Given
Given(/^I visit Home page$/) do
  visit('/')
end

Given(/^I visit Good Deeds page$/) do
  visit('/')
end

# Whens
When /^I click (.+) link$/ do |link|
  click_link(link)
end

# Thens
Then /^I see (.+) link$/ do |link|
  expect(page).to have_link(link)
end

Then /^I am on Home page$/ do
  assert_path('/')
end

Then /^I am on Good Deeds page$/ do
  assert_path('/good_deeds')
end

Then /^I am on Legislators page$/ do
  assert_path('/legislators')
end

Then /^I am on Bills page$/ do
  assert_path('/bills')
end

Then /^I am on Search page$/ do
  assert_path('/search')
end

Then /^I am on Signup page$/ do
  assert_path('signup')
end

Then /^I am on Login page$/ do
  assert_path('/login')
end
