class MerchantsController < ApplicationController
  before_action :retrieve_location
  before_action :retrieve_merchants, only: [:index]
  before_action :retrieve_merchant, only: [:show]

  def index
    return unless @location.blank?
    flash[:alert] = "You must enter a ZIP to search by."
  end

  private

  def locu_client
    Locu::Client.new(Rails.application.secrets.locu_api_key)
  end

  def search_params
    params.permit(:location)
  end

  def retrieve_location
    @location = search_params[:location]
  end

  def retrieve_merchants
    return @merchants = [] unless search_params[:location].present?

    cache_expires = AppConfig.locu.caching_time.days
    cache_name = "merchant_results_#{@location}"

    @merchants = Rails.cache.fetch(cache_name, expires_in: cache_expires) do
      result = SearchLocuVenues.call(client: locu_client,
                                     postal_code: @location)
      result.merchants
    end
  end

  def retrieve_merchant
    @merchant = Merchant.with_menus.find(params[:id])
  end
end
