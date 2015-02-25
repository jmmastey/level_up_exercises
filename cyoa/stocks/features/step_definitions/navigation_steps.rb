require 'pry'
When(/^I click on a stock$/) do
  page.execute_script("goToStock('AAPL');")
end

Given(/^stocks exist$/) do
  FactoryGirl.create(:stock, symbol: "AAPL")
  FactoryGirl.create(:stock, symbol: "MSFT")
  FactoryGirl.create(:stock, symbol: "TSLA")
end

Then(/^I am taken to that stock's detail page$/) do
  expect(page).to have_selector(".stock-title")
end

Given(/^I am on a stock's detail page$/) do
  visit '/stocks/AAPL'
end

When(/^I click the stocks button$/) do
  find(".stocks_btn").click
end

Then(/^I am taken to the index page$/) do
  expect(page).to have_selector('.stock_index')
end

Given(/^that I am logged in$/) do
  password = "12341234"
  email = 'zach@me.com'
  FactoryGirl.create(:user, :with_stocks, email: email, password: password)
  visit '/users/sign_in'
  fill_in('Email', with: email)
  fill_in('Password', with: password)
  click_button("Log in")
end

Then(/^I am taken to the watchlist page$/) do
  expect(page).to have_selector(".watchlist_index")
end