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
    @forecast = Forecast.recent(params[:zip_code]).last ||
      Forecast.retrieve(params[:zip_code])
    respond_to do |format|
      format.html
      format.json { render json: @forecast.to_json }
    end
  end
end
