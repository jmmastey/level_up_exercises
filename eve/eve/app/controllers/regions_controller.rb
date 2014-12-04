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

  def regions
    Region.order(:in_game_id)
  end

  def search_regions
    @search_query = params[:query]
    return regions unless @search_query.present?
    @search_query = @search_query.strip.upcase
    regions.where("UPPER(name) like ?", "%#{@search_query}%")
  end
end
