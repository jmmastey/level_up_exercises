class ItemsController < ApplicationController
  before_action :set_items, only: :index
  before_action :set_item, only: :show

  def index
    respond_to do |format|
      format.html do
        @items = @items.page(params[:page])
        render haml: @items
      end
      format.json
      format.xml
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @item }
      format.xml { render xml: @item }
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

  def set_item
    @item = Item.find(params[:id])
  end

  def set_items
    @items = items
  end
end
