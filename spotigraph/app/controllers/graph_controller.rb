class GraphController < ApplicationController
  def index
    # User visited root
  end

  def generate_graph
    if validate_depth(params[:depth])
      load_graph(params[:name], params[:depth].to_i)
    else
      return_bad_request_status
    end
  end

  private

  def validate_depth(param)
    max_depth = 5
    return false if param.nil?
    param == '0' || (param.to_i > 0 && param.to_i <= max_depth)
  end

  def load_graph(name, depth)
    cached = Graph.find_by(artist: name, depth: depth)
    if cached.nil?
      setup_graph(name, depth)
    else
      load_cached(cached)
    end
  end

  def load_cached(graph)
    @nodes = graph.nodes
    @edges = graph.edges
  end

  def setup_graph(name, depth)
    nodes_edges = Graph.search(name, depth)
    not_found_flash(name) if nodes_edges[0] == {}
    @nodes, @edges = GraphJSON.new.to_json(nodes_edges[0], nodes_edges[1])
    Graph.create!(artist: name, depth: depth, nodes: @nodes, edges: @edges)
  end

  def return_bad_request_status
    render :index, status: 400
  end

  def not_found_flash(name)
    flash[:danger] = "#{name} could not be found as a Spotify artist." \
                     ' Please double check the spelling.'
  end
end
