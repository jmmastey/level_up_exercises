class WeatherController < ApplicationController
  def index
    Rails.logger.info " PARAMS #{params["region"]["name"].inspect}"
  end

  def show
  end
end
