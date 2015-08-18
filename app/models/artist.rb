# Graph generation. This recursively builds the tree of artists.
class Artist < ActiveRecord::Base
  serialize :related, Array

  def self.search(name, depth)
    return [{}, {}] if valid_parameters(depth, name)
    current_artist = Artist.lookup_artist(name)
    return [{}, {}] if current_artist.nil?
    node_depth = { current_artist.name => depth }
    network = { current_artist.name => current_artist.related }
    depth -= 1
    current_artist.related.each do |related|
      merge_recursive_step(network, node_depth, Artist.search(related, depth))
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
    related = Artist.collect_related_artists(artist.related_artists)
    Artist.create!(name: artist.name, json: artist.to_json, related: related)
  end

  # Collect the related artist names into an array of strings
  def self.collect_related_artists(related_artists)
    related_artists.map(&:name)
  end

  # Returns nil unless we find a precise match against the searched artist
  def self.find_artist_in_array(artist_array, name)
    artist_array.each do |artist|
      return artist if artist.name.downcase == name.downcase
    end
    nil
  end

  # A hash merge with the strategy of selecting the max value with keys in both
  # hashes. Used to keep track of the maximal depths of nodes.
  def self.depth_merge!(hash_1, hash_2)
    merged = {}
    depth_1 = hash_1.clone
    depth_2 = hash_2.clone
    depth_1.each do |key, value|
      maximal_hash_merge(depth_1, depth_2, merged, key, value)
    end
    merged.merge!(depth_2)
  end

  class << self
    private

    def valid_parameters(depth, name)
      depth <= 0 || name.nil? || name == ''
    end

    # Merges the subsequent recursive steps into our current step's data
    def merge_recursive_step(network, node_depth, recursive_step)
      network.merge!(recursive_step[0])
      node_depth.replace(Artist.depth_merge!(node_depth, recursive_step[1]))
    end

    # Main strategy for the maximal hash merging.
    def maximal_hash_merge(depth_1, depth_2, currently_merged, key, value)
      depth_1.delete(key) if value.nil?
      depth_2.delete(key) if depth_2[key].nil?
      if depth_2.key?(key)
        currently_merged[key] = [value.to_i, depth_2[key].to_i].max
        depth_2.delete(key)
      else
        currently_merged[key] = value
      end
    end
  end
end
