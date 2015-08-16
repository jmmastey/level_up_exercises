class Artist < ActiveRecord::Base
  serialize :related,Array

  def self.search(name, depth)
    return [{}, {}] if depth <= 0 || name.nil? || name == ''
    current_artist = Artist.lookup_artist(name)
    return [{}, {}] if current_artist.nil?
    node_depth = { current_artist.name => depth }
    network = { current_artist.name => current_artist.related }
    current_artist.related.each do |related|
      recursive_step = Artist.search(related, depth - 1)
      network.merge!(recursive_step[0])
      node_depth = Artist.depth_merge!(node_depth, recursive_step[1])
    end
    [network, node_depth]
  end

  def self.lookup_artist(name)
    artist = Artist.find_by(name: name)
    return Artist.search_spotify(name) if artist.nil?
    artist
  end

  def self.search_spotify(name)
    artist = Artist.find_artist_in_array(RSpotify::Artist.search(name), name)
    return nil if artist.nil?
    Artist.create!(name: artist.name, json: artist.to_json, related: Artist.collect_related_artists(artist.related_artists))
  end

  # Collect the related artist names into an array of strings
  def self.collect_related_artists(related_artists)
    related_artists.map { |artist| artist.name }
  end

  # Returns nil unless we find a precise match against the searched artist
  def self.find_artist_in_array(artist_array, name)
    return nil if artist_array.size == 0
    artist_array.each do |artist|
      return artist if artist.name.downcase == name.downcase
    end
    nil
  end

  # A hash merge with the strategy of selecting the max value with keys in both
  # hashes. Used to keep track of the maximal depths of nodes.
  def self.depth_merge!(depth_1, depth_2)
    merged = {}
    depth_1.each do |key, value|
      depth_1.delete(key) if value.nil?
      depth_2.delete(key) if depth_2[key].nil?
      if depth_2.key?(key)
        merged[key] = [ value.to_i, depth_2[key].to_i ].max
        depth_2.delete(key)
      else
        merged[key] = value
      end
    end
    merged.merge!(depth_2)
  end
end
