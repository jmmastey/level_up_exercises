class StationsController < ApplicationController
  def index
    @stations = stations

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
    @stations = search_stations

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

  def query
    @query ||= (params[:query] || "").strip
  end

  def stations
    Station.order(:in_game_id)
  end

  def search_stations
    stations.where("UPPER(name) like ?", "%#{query.upcase}%")
  end
end
