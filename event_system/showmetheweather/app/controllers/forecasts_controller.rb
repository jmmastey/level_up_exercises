require "nws/rest_service"

class ForecastsController < ApplicationController
  def index
    if user_signed_in?
      redirect_to action: "show", zip_code: current_user.zip_code
    end
  end

  def search
    unless params[:forecast][:zip_code] =~ /^\d{5}$/
      flash[:danger] = "Invalid ZIP code"
      redirect_to action: "index"
      return
    end
    redirect_to action: "show", zip_code: params[:forecast][:zip_code]
  end

  def show
    @forecast = Forecast.recent(params[:zip_code]).last
    retrieve_and_store_forecast(params[:zip_code]) unless @forecast
    respond_to do |format|
      format.html
      format.json { render json: @forecast.to_json }
    end
  end

  private

  def retrieve_and_store_forecast(zip_code)
    forecast = retrieve_forecast(zip_code)
    store_forecast(forecast)
  end

  def retrieve_forecast(zip_code)
    NWS::RestService.forecast_by_zip_code(zip_code, days: 7)
  end

  def store_forecast(forecast)
    ActiveRecord::Base.transaction do
      @forecast = Forecast.create!(zip_code: forecast.zip_code)
      forecast.periods.each_pair do |name, attributes|
        store_period(name, attributes)
      end
    end
  end

  def store_period(name, attributes)
    period = Period.create!(name: name, start: attributes[:start_time],
      end: attributes[:end_time], forecast: @forecast)
    attributes[:predictions].each_pair do |label, value|
      Prediction.create!(label: label, value: value, period: period)
    end
  end
end
