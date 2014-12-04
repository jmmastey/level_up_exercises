class ItemsController < ApplicationController
  def index
    @items = items

    respond_to do |format|
      format.html do
        @items = @items.page(params[:page])
        render haml: @items
      end
      format.json do
        render json: @items
      end
    end
  end

  def search
    @items = search_items

    respond_to do |format|
      format.html do
        @items = @items.page(params[:page])
        render :index, haml: @items
      end
      format.json do
        render :index, json: @items
      end
    end
  end

  private

  def items
    Item.order(:in_game_id)
  end

  def query
    @query ||= (params[:query] || "").strip
  end

  def search_items
    items.where("UPPER(name) like ?", "%#{query.upcase}%")
  end
end
