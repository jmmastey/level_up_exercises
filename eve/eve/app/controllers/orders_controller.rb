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
    @search_query = params[:query]


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

  def show
  end

  private

  def get_orders
    Order.all
  end
end
