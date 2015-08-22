# Converts our graph data into the JSON required by vis.js
class GraphJSON
  def to_json(graph, depth)
    @depth = depth
    @visited_nodes = {}
    [nodes_to_json(graph), edges_to_json(graph)]
  end

  private

  def nodes_to_json(network)
    id = 0
    nodes = network.map do |name, _related|
      id += 1
      convert_single_node(name, id) unless @visited_nodes.key?(name.downcase)
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

  # Logs that we have visited a node and sets up the hash for that node.
  def convert_single_node(name, id)
    @visited_nodes[name.downcase] = id
    { id: id, label: name, color: colors(@depth[name]) }
  end
end
