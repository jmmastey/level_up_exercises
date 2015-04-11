require 'spec_helper'

describe ParseTemperatures do
  context "when there is no data" do

    before do
      allow(WeatherForecast).to receive(:today).and_return(WeatherForecast.none)
    end

    it "inserts data in the database" do
      expect{ ParseTemperatures.call }.to change(WeatherForecast, :count).by(5)
    end
  end

   context "when there is no data" do
    before do
      allow(WeatherForecast).to receive(:today).and_return([{ "high" => 30, "low" => 20 }])
    end

    it " does not insert data in the database" do
      expect{ ParseTemperatures.call }.to_not change(WeatherForecast, :count)
    end
   end
end