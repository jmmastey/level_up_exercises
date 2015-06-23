require 'net/http'

Given(/^I am logged in$/) do
  visit('/users/sign_up') 
  fill_in("Email", with: "mittens@gmail.com")
  fill_in("Password", with: "testpassword")
  fill_in("Password confirmation", with: "testpassword")
  click_button("Sign up")
end

When(/^I click on Book Search$/) do
  click_link("Book Search")
end

When(/^I search for a book$/) do
    fill_in("Title", with: "Isaac's Storm")
    click_button("Search")
end

Then(/^I add it to my library$/) do
  click_link("Title: Isaac's storm : a man, a time, and the deadliest hurricane in history Author: Larson, Erik, 1954- | Cline, Isaac Monroe, 1861-1955 [Author] Format: Book")
end

Then(/^I see that it is stored in my library$/) do
  page.has_content?("added to your library")
  expect(page).to have_content("Isaac's storm")
end

