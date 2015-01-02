Given(/^I have favorited (\d+) artists$/) do |arg1|
  artist_1 = create(:artist, first_name: "Claude",  last_name: "Monet")
  artist_2 = create(:artist, first_name: "Edouard", last_name: "Manet")
  user = create(:user, email: "user@example.com", password: "secret" )
  user.favorite_artists << artist_1
  user.favorite_artists << artist_2
  visit new_user_session_path
  fill_in("Email", with: "user@example.com")
  fill_in("Password", with: "secret")
  click_button("Log in")
end

Given(/^I am logged in and on an artist page$/) do
  user = create(:user, email: "user@example.com", password: "secret" )
  artist_1 = create(:artist, first_name: "Claude",  last_name: "Monet")
  visit new_user_session_path
  fill_in("Email", with: "user@example.com")
  fill_in("Password", with: "secret")
  click_button("Log in")
  visit artist_path(artist_1)
end

Given(/^I am not logged in and on an artist page$/) do
  visit artist_path(artist_1)
end

Given(/^I am logged in and on an artist page I have favorited$/) do
  user = create(:user, email: "user@example.com", password: "secret" )
  artist_1 = create(:artist, first_name: "Claude",  last_name: "Monet")
  visit new_user_session_path
  fill_in("Email", with: "user@example.com")
  fill_in("Password", with: "secret")
  click_button("Log in")
  visit artist_path(artist_1)
  click_button("Favorite Artist")
end

When(/^I click the Favorite Artist button$/) do
  click_button("Favorite Artist")
end

When(/^I click the Unfavorite Artist button$/) do
  click_button("Unfavorite Artist")
end

Then(/^I should see my favorite artists on my user page$/) do
  expect(page).to have_content("Claude Monet")
  expect(page).to have_content("Edouard Manet")
end

Then(/^I should see the artist on my user page$/) do
  click_link("My Profile")
  expect(page).to have_content("Claude Monet")
end

Then(/^I should not see a Favorite Artist button$/) do
  expect(page).to_not have_content("Unfavorite Artist")
end

Then(/^I should not see the artist on my user page$/) do
  click_link("My Profile")
  expect(page).to_not have_content("Claude Monet")
end

Then(/^I should not see a Unfavorite Artist button$/) do
  expect(page).to_not have_content("Unfavorite Artist")
end
