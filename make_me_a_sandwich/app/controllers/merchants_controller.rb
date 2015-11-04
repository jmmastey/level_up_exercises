class MerchantsController < ApplicationController
  before_action :authenticate_user!
  before_action :retrieve_merchants, only: [:index]
  before_action :retrieve_merchant, only: [:show]

  def index
    @location = search_params[:location]
  end

  private

  def search_params
    params.permit(:location)
  end

  def retrieve_merchants
    @merchants = Merchant.in_zip(search_params[:location])
  end

  def retrieve_merchant
    @merchant = Merchant.find(params[:id])
  end
end
