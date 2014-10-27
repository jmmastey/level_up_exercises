class ItemsController < ApplicationController
  def index
    @search_query = params[:q]
    @items = get_items
    @items = search_items(@items, @search_query) if @search_query

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

  private

  def get_items
    Item.order(:in_game_id)
  end

  def search_items(items, query)
    query = query.strip.upcase
    items.where("UPPER(name) like ?", "%#{query}%")
  end
end
