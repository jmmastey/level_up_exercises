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
    search_orders

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

  def orders
    Order.all
  end

  def search_orders
    @orders = orders
    @orders = @orders.by_item(params[:item]) if params[:item].present?
    @orders = @orders.by_region(params[:region]) if params[:region].present?
    @orders = @orders.by_station(params[:station]) if params[:station].present?
  end
end
