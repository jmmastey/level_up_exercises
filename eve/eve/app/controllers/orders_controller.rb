class OrdersController < ApplicationController
  def index
    @orders = orders

    respond_to do |format|
      format.html do
        @orders = @orders.page(params[:page])
        render haml: @orders
      end
      format.json do
        render json: @orders
      end
    end
  end

  def search
    @orders = search_orders

    respond_to do |format|
      format.html do
        @orders = @orders.page(params[:page])
        render :index, haml: @orders
      end
      format.json do
        render :index, json: @orders
      end
    end
  end

  private

  def assign_search_params
    @item = params[:item]
    @region = params[:region]
    @station = params[:station]
  end

  def orders
    Order.all
  end

  def search_orders
    orders
      .by_item(@item)
      .by_region(@region)
      .by_station(@station)
  end
end
