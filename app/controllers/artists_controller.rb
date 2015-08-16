class ArtistsController < ApplicationController
  def index
    # User visited root
  end
  def generate_graph
    if validate_depth(params[:depth])
      nodes_edges = Artist.search(params[:name], params[:depth].to_i)
      generate_flash(params[:name]) if nodes_edges[0] == {}
      @nodes, @edges = GraphJSON.new.to_json(nodes_edges[0], nodes_edges[1])
    else
      return_bad_request_status
    end
  end

  private
  def validate_depth(param)
    max_depth = 6
    return false if param.nil?
    param == '0' || (param.to_i > 0 && param.to_i <= max_depth)
  end

  def return_bad_request_status
    render :nothing => true, :status => 400
  end

  def generate_flash(name)
    flash[:danger] = "#{name} could not be found as a Spotify artist." << \
                       ' Please double check the spelling.'
  end
end
