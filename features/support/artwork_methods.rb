def create_artwork
  artist_1 = FactoryGirl.create(:artist) do |artist|
   artist.artworks << FactoryGirl.create(:artwork)
  end
  visit artist_artwork_path(artist_1, artist_1.artworks.first)
end

def create_a_new_artwork(artwork)
  artist_1 = FactoryGirl.create(:artist)
  visit artist_artworks_path(artist_1)
  click_link("Create a New Artwork")
  fill_in("Title", with: artwork)
  fill_in("Date Created", with: "1931")
  click_button("Create Artwork")
end
