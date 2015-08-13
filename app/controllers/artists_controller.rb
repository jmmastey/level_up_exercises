class ArtistsController < ApplicationController
  def new
  end

  def generate_graph
    graph_generator = GraphJSON.new
    if params[:name].nil? || params[:name] == '' || params[:depth].nil? || params[:depth] == ''
      @nodes = '{}'
      @edges = '{}'
    else
      name = params[:name]
      depth = params[:depth].to_i
      # CALL BACKGROUND WORKER -> RENDER
      graph_nodes = Artist.search(name, depth)
      if graph_nodes[0] == {}
        flash[:danger] = params[:name] + \
        ' could not be found as a Spotify artist. Please double check the spelling.'
      end
      @nodes, @edges = graph_generator.to_json(graph_nodes[0], graph_nodes[1])
    end
  end
end
