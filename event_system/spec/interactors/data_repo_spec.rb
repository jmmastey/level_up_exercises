require 'spec_helper'

describe DataRepo do
  let(:model_name) { WeatherForecast }
  let(:method_name) { :scrape_temperatures }
  let(:attributes) { %w(high low) }

  context "when model is empty" do
    it "calls parse_scraped_data method" do
      allow(model_name).to receive(:today).and_return(WeatherForecast.none)

      expect(DataRepo).to receive(:parse_scraped_data).and_return(Proc.new{})

      DataRepo.call(model_name, method_name, attributes)
    end

    it "does not calls parse_scraped_data method" do
      allow(model_name).to receive(:today).and_return([{high: 40, low: 30}])

      expect(DataRepo).to receive(:structure_data).and_return(Proc.new{})
      DataRepo.call(model_name, method_name, attributes)
    end
  end
end