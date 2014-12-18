Given(/^I am on the page for an artwork$/) do
  artist_1 = FactoryGirl.create(:artist) do |artist|
   artist.artworks << FactoryGirl.create(:artwork)
  end
  visit artist_artwork_path(artist_1, artist_1.artworks.first)
end

Then(/^I should see the artwork$/) do
  expect(page).to have_content("The Old Violin")
end
