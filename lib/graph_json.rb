# Converts our graph data into the JSON required by vis.js
class GraphJSON
  def to_json(graph, depth)
    @depth = depth
    return nodes_to_json(graph), edges_to_json(graph)
  end

  private

  def nodes_to_json(network)
    nodes = []
    id = 1
    @visited_nodes = {}
    network.each do |key|
      name = key[0]
      next if @visited_nodes.key?(name.downcase)
      id = convert_single_node!(name, id, nodes)
    end
    nodes.to_json
  end

  def edges_to_json(network)
    edges = []
    network.each do |key|
      edges.concat(generate_artist_edges(key[0], key[1]))
    end
    edges.to_json
  end

  def generate_artist_edges(artist, related)
    edges = []
    from = @visited_nodes[artist.downcase]
    related.each do |related_artist|
      to = @visited_nodes[related_artist.downcase]
      both_required = !from.nil? && !to.nil?
      edges << { from: from, to: to } if both_required
    end
    edges
  end

  def colors(depth)
    %w(#4A5F70 #7F825f #C2AE95 #824E4E #66777D)[depth % 5]
  end

  # Modifies nodes!
  def convert_single_node!(name, id, nodes)
    nodes << { id: id, label: name, color: colors(@depth[name]) }
    @visited_nodes[name.downcase] = id
    id + 1
  end
end
