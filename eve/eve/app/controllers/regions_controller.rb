class RegionsController < ApplicationController
  def index
    @regions = regions

    respond_to do |format|
      format.html do
        @regions = @regions.page(params[:page])
        render haml: @regions
      end
      format.json do
        render json: @regions
      end
    end
  end

  def search
    @regions = search_regions

    respond_to do |format|
      format.html do
        @regions = @regions.page(params[:page])
        render :index, haml: @regions
      end
      format.json do
        render :index, json: @regions
      end
    end
  end

  private

  def query
    @query = (params[:query] || "").strip
  end

  def regions
    Region.order(:in_game_id)
  end

  def search_regions
    regions.where("UPPER(name) like ?", "%#{query.upcase}%")
  end
end
