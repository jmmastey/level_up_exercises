require "spec_helper"
require "nws/forecast"

module NWS
  describe Forecast do
    describe "#==" do
      context "when the fields of two forecast objects are the same" do
        it "returns true" do
          expect(Forecast.new("60606", {})).to eq(Forecast.new("60606", {}))
        end
      end
      
      context "when the fields of two forecast objects are not the same" do
        it "returns false" do
          expect(Forecast.new("90210", {})).not_to eq(Forecast.new("60606", {}))
        end
      end
    end
  end
end
