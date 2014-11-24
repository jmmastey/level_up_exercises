class OrdersController < ApplicationController
  def index
    @orders = get_orders

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

  def show
  end

  private

  def get_orders
    Order.all
  end

  def search_orders
    orders = get_orders
    orders = orders.by_item(params[:item]) if params[:item]
    orders = orders.by_region(params[:region]) if params[:region]
    orders = orders.by_station(params[:station]) if params[:station]

    orders
  end
end
