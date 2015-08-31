# Graph generation. This recursively builds the tree of graph.
class Artist < ActiveRecord::Base
  serialize :related, Array

  def self.lookup_artist(name)
    Artist.find_by(name: name) || Artist.cache_artist(Artist.search_spotify(name))
  end

  def self.search_spotify(name)
    artist = RSpotify::Artist.search(name)
    Artist.find_matching_name(artist, name)
  end

  # Returns nil unless we find a precise match against the searched artist
  def self.find_matching_name(artist_array, name)
    artist_array.find { |artist| artist.name.downcase == name.downcase }
  end

  # Collect the related artist names into an array of strings
  def self.collect_related_artists(related_artists)
    related_artists.map(&:name)
  end

  def self.cache_artist(artist)
    return nil if artist.nil?
    related = Artist.collect_related_artists(artist.related_artists)
    Artist.create!(name: artist.name, json: artist.to_json, related: related)
  end
end
