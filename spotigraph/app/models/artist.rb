# Graph generation. This recursively builds the tree of graph.
class Artist < ActiveRecord::Base
  serialize :related, Array

  def self.lookup_artist(name)
    artist = Artist.find_by(name: name)
    return Artist.search_spotify(name) if artist.nil?
    artist
  end

  def self.search_spotify(name)
    artist = Artist.find_artist_in_array(RSpotify::Artist.search(name), name)
    return nil if artist.nil?
    related = Artist.collect_related_artists(artist.related_artists)
    Artist.create!(name: artist.name, json: artist.to_json, related: related)
  end

  # Returns nil unless we find a precise match against the searched artist
  def self.find_artist_in_array(artist_array, name)
    artist_array.find { |artist| artist.name.downcase == name.downcase }
  end

  # Collect the related artist names into an array of strings
  def self.collect_related_artists(related_artists)
    related_artists.map(&:name)
  end
end
