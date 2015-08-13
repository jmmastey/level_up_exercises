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
    network.each do |key, value|
      next if @visited_nodes.key?(key)
      nodes << {id: id, label: key, color: colors(@depth[key])}
      @visited_nodes[key] = id
      id += 1
      value.each do |val|
        next if @visited_nodes.key?(key)
        nodes << {id: id, label: val, color: colors(@depth[val])}
        @visited_nodes[val] = id
        id += 1
      end
    end
    nodes.to_json
  end

  def edges_to_json(network)
    edges = []
    network.each do |key, value|
      value.each do |related|
        edges << {from:  @visited_nodes[key], to: @visited_nodes[related]}
      end
    end
    edges.to_json
  end

  def colors(depth)
    %w(#4A5F70 #7F825f #C2AE95 #824E4E #66777D)[depth % 5]
  end
end