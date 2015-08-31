class Graph < ActiveRecord::Base
  def self.search(name, depth)
    return [{}, {}] if invalid_parameters?(depth, name)
    current_artist = Artist.lookup_artist(name)
    return [{}, {}] if current_artist.nil?
    node_depth = { current_artist.name => depth }
    network = { current_artist.name => current_artist.related }
    current_artist.related.each do |related|
      merge_recursive_step(network, node_depth, Graph.search(related, depth - 1))
    end
    [network, node_depth]
  end

  # A hash merge with the strategy of selecting the max value with keys in both
  # hashes. Used to keep track of the maximal depths of nodes.
  def self.depth_merge!(hash_1, hash_2)
    hash_1.merge(hash_2) { |_key, old, new| [old.to_i, new.to_i].max }
  end

  def self.invalid_parameters?(depth, name)
    depth <= 0 || name.nil? || name == ''
  end

  # Merges the subsequent recursive steps into our current step's data
  def self.merge_recursive_step(network, node_depth, recursive_step)
    network.merge!(recursive_step[0])
    node_depth.replace(Graph.depth_merge!(node_depth, recursive_step[1]))
  end
  private_class_method :invalid_parameters?, :merge_recursive_step
end
