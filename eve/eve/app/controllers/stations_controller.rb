class StationsController < ApplicationController
  def index
    @stations = get_stations

    respond_to do |format|
      format.html do
        @stations = @stations.page(params[:page])
        render haml: @regions
      end
      format.json do
        render json: @regions
      end
    end
  end

  def search
    @search_query = params[:query]
    @stations = search_stations(@search_query) if @search_query

    respond_to do |format|
      format.html do
        @stations = @stations.page(params[:page])
        render :index, haml: @regions
      end
      format.json do
        render :index, json: @regions
      end
    end
  end

  def show
  end

  private

  def get_stations
    Station.order(:in_game_id)
  end

  def search_stations(query)
    stations = get_stations
    query = query.strip.upcase
    stations.where("UPPER(name) like ?", "%#{query}%")
  end
end
