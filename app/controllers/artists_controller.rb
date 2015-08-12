class ArtistsController < ApplicationController
  def new
  end

  def generate_graph
    graph_generator = GraphGeneration.new
    if params[:name].nil? || params[:name] == '' || params[:depth].nil? || params[:depth] == ''
      @nodes = '{}'
      @edges = '{}'
    else
      name = params[:name]
      depth = params[:depth].to_i
      graph = graph_generator.search(name, depth)
      if graph == {}
        flash[:danger] = params[:name] + \
        ' could not be found as a Spotify artist. Please double check the spelling.'
      end
      @nodes = graph_generator.nodes_to_json(graph)
      @edges = graph_generator.edges_to_json(graph)
    end
  end
end
