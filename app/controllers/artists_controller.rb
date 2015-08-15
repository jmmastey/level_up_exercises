class ArtistsController < ApplicationController
  def index
    # User visited /
  end
  def generate_graph
    graph_json = GraphJSON.new
    name = params[:name]
    depth = params[:depth].to_i
    nodes_edges = Artist.search(name, depth)
    if nodes_edges[0] == {}
      flash[:danger] = "#{name} could not be found as a Spotify artist." << \
                       ' Please double check the spelling.'
    end
    @nodes, @edges = graph_json.to_json(nodes_edges[0], nodes_edges[1])
  end
end
