class MerchantsController < ApplicationController
  before_action :authenticate_user!
  before_action :retrieve_merchants, only: [:index]
  before_action :retrieve_merchant, only: [:show]

  def index
    @location = search_params[:location]

    if @location.blank?
      flash[:alert] = "You must enter a ZIP to search by."
    end
  end

  private

  def search_params
    params.permit(:location)
  end

  def retrieve_merchants
    return @merchants = [] unless search_params[:location].present?
    @merchants = Merchant.in_zip(search_params[:location])
  end

  def retrieve_merchant
    @merchant = Merchant.with_menus.find(params[:id])
  end
end
