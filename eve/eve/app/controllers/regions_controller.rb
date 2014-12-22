class RegionsController < ApplicationController
  before_action :set_regions, only: :index
  before_action :set_region, only: :show
  before_action :search_regions, only: :search
  respond_to :html, :xml, :json

  def index
    respond_to do |format|
      format.html do
        @regions = @regions.page(params[:page])
        render :index, haml: @regions
      end
      format.json { render :index, json: @regions }
      format.xml { render :index, xml: @regions }
    end
  end

  def search
    respond_to do |format|
      format.html do
        @regions = @regions.page(params[:page])
        render :index, haml: @regions
      end
      format.json { render :index, json: @regions }
      format.xml { render :index, xml: @regions }
    end
  end

  private

  def query
    @query ||= (params[:query] || "").strip
  end

  def regions
    Region.order(:in_game_id)
  end

  def search_regions
    @regions = regions.where("UPPER(name) like ?", "%#{query.upcase}%")
  end

  def set_regions
    @regions = regions
  end

  def set_region
    @region = regions.find(params[:id])
  end
end
