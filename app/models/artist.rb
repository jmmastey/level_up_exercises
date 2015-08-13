class Artist < ActiveRecord::Base
  serialize :related,Array

  def self.search(name, depth)
    return [{}, {}] if depth <= 0
    current_artist = Artist.find_by_name(name)
    current_artist = Artist.lookup_one(name) if current_artist.nil?
    return [{}, {}] if current_artist.nil?
    node_depth = {}
    node_depth[current_artist.name] = depth
    network = { current_artist.name => current_artist.related }
    current_artist.related.each do |related|
      recursive_step = Artist.search(related, depth - 1)
      network.merge!(recursive_step[0])
      node_depth = Artist.depth_merge!(node_depth, recursive_step[1])
    end
    [network, node_depth]
  end

  def self.lookup_one(name)
    artist = Artist.find_artist(RSpotify::Artist.search(name), name)
    return nil if artist.nil?
    Artist.create!(name: artist.name, json: artist.to_json, related: Artist.generate_related_artists(artist.related_artists))
  end

  def self.generate_related_artists(related_artists)
    names = []
    related_artists.each do |artist|
      names << artist.name
    end
    names
  end

  def self.find_artist(artist_array, name)
    return nil if artist_array.size == 0
    artist_array.each do |artist|
      return artist if artist.name.downcase == name.downcase
    end
    nil
  end

  def self.depth_merge!(depth_1, depth_2)
    merged = {}
    depth_1.each do |key, value|
      depth_1.delete(key) if value.nil?
      if depth_2.key?(key)
        depth_2.delete(key) if depth_2[key].nil?
        merged[key] = [value, depth_2[key]].max
        depth_2.delete(key)
      else
        merged[key] = value
      end
    end
    merged.merge!(depth_2)
  end
end
