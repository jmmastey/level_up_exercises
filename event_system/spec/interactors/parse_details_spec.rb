require 'spec_helper'

describe ParseDetails do
  context "when there is no data" do

    before do
      allow(WeatherForecastDetail).to receive(:today).and_return(WeatherForecastDetail.none)
    end

    it "inserts data in the database" do
      expect{ ParseDetails.call }.to change(WeatherForecastDetail, :count).by(7)
    end
  end

   context "when there is no data" do
    before do
      allow(WeatherForecastDetail).to receive(:today).and_return([{ "high" => 30, "low" => 20 }])
    end

    it " does not insert data in the database" do
      expect{ ParseDetails.call }.to_not change(WeatherForecastDetail, :count)
    end
   end
end
