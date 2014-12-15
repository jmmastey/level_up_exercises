require 'json'

module ArtistParser

  def self.parse(file)
    artist_hash = JSON.parse(file)
  end
end
