require 'rails_helper'

RSpec.describe ForecastController, type: :controller do

  describe "GET index" do
    let!(:condition) { create(:current_weather) }
    let!(:hourly_forecasts) do
      10.times.map do |i|
        FactoryGirl.create(:hourly_forecast, zip_code: 60606,
                           time: Time.now.beginning_of_hour + i.hours * 3)
      end
    end
    let!(:forecasts) do
      (1..18).map do |i|
        create(:forecast, zip_code: 60606,
         time: (Time.now.beginning_of_hour + i.days * 0.5))
      end
    end

    it "returns http success and data" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:conditions)).to eq condition
      expect(assigns(:forecasts)).to eq forecasts.take(14)
      expect(assigns(:hourly_forecast)).to eq hourly_forecasts.take(8)
    end

    it "returns historical data not present" do
      get :index, start_time: Time.now - 14.days
      expect(response).to have_http_status(:success)
      expect(assigns(:conditions)).to be_nil
      expect(assigns(:forecasts)).to be_empty
      expect(assigns(:hourly_forecast)).to be_empty
    end
    
    it "returns partial data for historical request" do
      get :index, start_time: Time.now - 0.5.days
      expect(response).to have_http_status(:success)
      expect(assigns(:conditions)).to be nil
      expect(assigns(:forecasts)).to eq forecasts.take(13)
      expect(assigns(:hourly_forecast)).to eq hourly_forecasts.take(5)
    end
  end

end
