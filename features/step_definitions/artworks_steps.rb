Given(/^I am on the page for an individual artwork$/) do
  artist_1 = FactoryGirl.create(:artist) do |artist|
   artist.artworks << FactoryGirl.create(:artwork)
  end
  visit artist_artwork_path(artist_1, artist_1.artworks.first)
end

Given(/^I am on a page for an artist with an artwork$/) do
  artist_1 = FactoryGirl.create(:artist) do |artist|
   artist.artworks << FactoryGirl.create(:artwork)
  end
  visit artist_path(artist_1)
end

Given(/^I am on an artist's artworks page$/) do
  artist_1 = FactoryGirl.create(:artist)
  visit artist_artworks_path(artist_1)
end

When(/^I create a new artwork: (.+)$/) do |artwork|
  click_link("New Artwork")
  fill_in("Title", with: artwork)
  fill_in("Date Created", with: "1931")
  click_button("Create Artwork")
end

When(/^I create an invalid artwork$/) do
  artist_1 = FactoryGirl.create(:artist)
  visit artist_artworks_path(artist_1)
  click_link("New Artwork")
  fill_in("Title", with: "")
  fill_in("Date Created", with: "")
  click_button("Create Artwork")
end

Then(/^I should see the artwork$/) do
  expect(page).to have_content("The Old Violin")
end

Then(/^I should see the artist's artworks$/) do
  expect(page).to have_content("The Old Violin")
end

Then(/^I should see a message confirming the artwork was (.+)$/) do |action|
  expect(page).to have_content("The artwork was successfully #{action}.")
end

Then(/^I should be on the artwork page for (.+)$/) do |artwork|
  expect(page).to have_css('h1', text: artwork)
end

Then(/^I should see artwork validation errors$/) do
  expect(page).to have_content("The artwork could not be saved.")
  expect(page).to have_content("Please correct the 2 errors below:")
  expect(page).to have_content("Title can't be blank.")
  expect(page).to have_content("Date can't be blank.")
end
