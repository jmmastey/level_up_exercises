Given(/^I am on the page for an individual artwork$/) do
  create_artwork
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
  create_a_new_artwork(artwork)
end

When(/^I create an invalid artwork$/) do
  artist_1 = FactoryGirl.create(:artist)
  visit artist_artworks_path(artist_1)
  click_link("New Artwork")
  fill_in("Title", with: "")
  fill_in("Date Created", with: "")
  click_button("Create Artwork")
end

When(/^I edit an artwork: (.+)$/) do |artwork|
  create_a_new_artwork(artwork)
  click_link("Edit Artwork")
end

When(/^I edit an artwork with invalid data: (.+)$/) do |artwork|
  create_a_new_artwork(artwork)
  click_link("Edit Artwork")
  fill_in("Title", with: "")
  fill_in("Date Created", with: "")
  click_button("Update Artwork")
end

When(/^I update the title to (.+)$/) do |title|
  fill_in("Title", with: title)
  click_button("Update Artwork")
end

When(/^I delete the artwork: (.+)$/) do |artwork|
  create_a_new_artwork(artwork)
  click_link("Delete Artwork")
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

Then(/^I should not see (.+) on the artworks page for the artist$/) do |artwork|
  expect(page).not_to have_css('h1', text: artwork)
end
