class Graph < ActiveRecord::Base
  # This is the main generation function for a graph. It checks that we are
  # Still at a valid depth, then builds the array of hashes (example below)
  # [{artist => [related1, related2]}, {artist => 1}]      (this uses depth 1)
  def self.search(name, depth)
    return [{}, {}] if invalid_depth?(depth.to_i)
    generate_related_artists(Artist.lookup_artist(name), depth.to_i)
  end

  # A hash merge with the strategy of selecting the max value with keys in both
  # hashes. Used to keep track of the maximal depths of nodes.
  def self.depth_merge!(hash_1, hash_2)
    hash_1.merge(hash_2) { |_key, old, new| [old.to_i, new.to_i].max }
  end

  # functions below are private

  def self.invalid_depth?(depth)
    depth <= 0 || depth >= 10
  end

  # Merges the subsequent recursive steps into our current step's data
  def self.merge_recursive_step(network, node_depth, recursive_step)
    network.merge!(recursive_step[0])
    node_depth.replace(Graph.depth_merge!(node_depth, recursive_step[1]))
  end

  def self.generate_related_artists(current_artist, depth)
    return [{}, {}] if current_artist.nil?
    node_depth = { current_artist.name => depth }
    network = { current_artist.name => current_artist.related }
    current_artist.related.each do |related|
      merge_recursive_step(
          network,
          node_depth,
          Graph.search(related, depth - 1)
      )
    end
    [network, node_depth]
  end

  private_class_method :invalid_depth?, :merge_recursive_step, :generate_related_artists
end
