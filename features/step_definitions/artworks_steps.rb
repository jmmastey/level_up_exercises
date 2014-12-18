Given(/^I am on the page for an artwork$/) do
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

Then(/^I should see the artwork$/) do
  expect(page).to have_content("The Old Violin")
end

Then(/^I should see the artist's artworks$/) do
  expect(page).to have_content("The Old Violin")
end
