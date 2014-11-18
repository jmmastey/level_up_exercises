class ItemsController < ApplicationController
  def index
    @items = get_items

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
    @search_query = params[:query]

    if @search_query
      @items = search_items(@search_query)
    else
      @items = get_items
    end

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

  def get_items
    Item.order(:in_game_id)
  end

  def search_items(query)
    items = get_items
    query = query.strip.upcase
    items.where("UPPER(name) like ?", "%#{query}%")
  end
end
