class RegionsController < ApplicationController
  def index
    @regions = get_regions

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
    @search_query = params[:query]
    @regions = search_regions(@search_query) if @search_query

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

  def get_regions
    Region.order(:in_game_id)
  end

  def search_regions(query)
    regions = get_regions
    query = query.strip.upcase
    regions.where("UPPER(name) like ?", "%#{query}%")
  end
end
