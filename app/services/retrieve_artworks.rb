class RetrieveArtworks
  attr_reader :artwork_collection, :link, :artist

  def initialize(url, artist)
    @artist = artist
    @link = ArtsyApiWrapper.get_artworks_from_artist(url)
    @artwork_collection = link["_embedded"]["artworks"] # This is an array of artworks
  end

  def build_artworks
    artwork_collection.each do |artwork|
      create_new_artwork(artwork)
    end
  end

  def create_new_artwork(artwork)
    artist_params = params(artwork)
    artist.artworks.create(artist_params)
  end

  def params(artwork)
    params = Hash.new
    params[:artwork] = {
      title: artwork["title"],
      date: artwork["date"],
      thumbnail: artwork["_links"]["thumbnail"]["href"]
    }
  end
end
