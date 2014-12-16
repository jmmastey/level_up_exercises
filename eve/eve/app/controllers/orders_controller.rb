class OrdersController < ApplicationController
  before_action :set_orders, only: :index
  before_action :set_order, only: :show
  before_action :search_orders, only: :search
  respond_to :html, :xml, :json

  def index
    respond_to do |format|
      format.html do
        @orders = @orders.page(params[:page])
        render haml: @orders
      end
      format.json
      format.xml
    end
  end

  def search
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
    assign_search_params
    @orders = orders.by_item(@item)
                    .by_region(@region)
                    .by_station(@station)
  end

  def set_orders
    @orders = orders
  end
end
