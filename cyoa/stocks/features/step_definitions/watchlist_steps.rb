Then(/^I see no stocks on my watchlist$/) do
  expect(page).not_to have_selector('watched_stock')
end

Given(/^I am on the index page$/) do
  visit '/'
end

When(/^I click the star next to a stock not already on my watchlist$/) do
  step "I am watching stocks"
end

Then(/^that stock is added to my watchlist$/) do
  visit '/watchlist'
  expect(page).to have_selector('.watched_stock')
end

Given(/^I am watching stocks$/) do
  find('.AAPL-btn').click
end

When(/^I click the star next to a stock already on my watchlist$/) do
  step "I am watching stocks"
end

Then(/^that stock is removed from my watchlist$/) do
  visit '/watchlist'
  expect(page).not_to have_selector('watched_stock')
end

Given(/^I am on the show page$/) do
  visit '/stocks/AAPL'
end

Given(/^that stock is not on my watchlist$/) do
  expect(find('#watchlist')).to have_content('Add To Watchlist')
end

When(/^I click the watchlist button$/) do
  find('.watchlist_btn').click
end

Given(/^that stock is on my watchlist$/) do
  expect(find('#watchlist')).to have_content('Add To Watchlist')
  find('.watchlist_btn').click
end
