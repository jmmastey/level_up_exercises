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


Given(/^I have a book in my library$/) do
  click_link("Book Search")
  fill_in("Title", with: "Isaac's Storm") 
  click_button("Search")
  click_link("Title: Isaac's storm : a man, a time, and the deadliest hurricane in history Author: Larson, Erik, 1954- | Cline, Isaac Monroe, 1861-1955 [Author] Format: Book")
  sleep(2)
end

When(/^I click on my library$/) do
  click_link("mittens@gmail.com's Library")
end

When(/^I select a book$/) do
  click_link("Isaac's storm : a man, a time, and the deadliest hurricane in history")
end

Then(/^I can see detailed information about the book$/) do
  expect(page).to have_content("Larson, Erik, 1954-")
end



When(/^I click on the recommend button$/) do
  click_button("Change your recommendation")
end

Then(/^I see a message indicating the book is recommended$/) do
  expect(page).to have_content("Thanks for your input!")
end




Given(/^I am not logged in$/) do
  click_link("Logout")
end

When(/^I click on Recommended Books$/) do
  click_link("Recommended Books")
end

Then(/^I see books recommended by other users$/) do
  expect(page).to have_link("Isaac's storm : a man, a time, and the deadliest hurricane in history")
end




When(/^I write a comment about the book$/) do
  fill_in(:comment, with: "This book is excellent.  It gives the reader a well rounded picture of the factors leading up to this disaster")
  click_button("Submit")
end

Then(/^I expect to see a message indicating my comment was successfully added$/) do
  expect(page).to have_content("Your comment was successfully added")
end


Given(/^I am on my library page$/) do
  click_link("mittens@gmail.com's Library")
end


Then(/^I can see comments that I have written about the book$/) do
  expect(page).to have_content("This book is excellent.  It gives the reader a well rounded picture of the factors leading up to this disaster")
end



When(/^I click to delete the book$/) do
  click_button("Delete Book")
end

Then(/^I see a message indicating the book was deleted$/) do
  expect(page).to have_content("Your book was successfully deleted")
end

Then(/^I see that the book is no longer in my library$/) do
  click_link("mittens@gmail.com's Library")
  expect(page).to have_no_content("Isaac's storm : a man, a time, and the deadliest hurricane in history")
end



When(/^I delete a comment about that book$/) do
  binding.pry
  click_button("Delete Comment")
end

Then(/^I see the comment was deleted$/) do
  expect(page).to have_content("Your comment was successfully deleted")
end

Then(/^I see the comment no longer exists on the book page$/) do
  click_link("mittens@gmail.com's Library")
  click_link("Isaac's storm : a man, a time, and the deadliest hurricane in history")
  binding.pry
  expect(page).to have_no_content("This book is excellent.  It gives the reader a well rounded picture of the factors leading up to this disaster")
end
