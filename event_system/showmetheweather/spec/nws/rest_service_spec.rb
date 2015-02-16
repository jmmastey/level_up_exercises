require "spec_helper"
require "nws/rest_service"
require "nws/forecast"
require "nws/dwml_parser"

module NWS
  describe RestService do
    describe "::forecast_by_zip_code" do
      let(:test_xml) { File.read(File.expand_path("../test.xml", __FILE__)) }
      let(:test_periods) do
        { "Today" => { predictions: { "High Temperature" => "24",
                                      "Chance of Precipitation" => "82",
                                      "Conditions" => "" },
                       start_time: "2015-02-03T06:00:00-06:00",
                       end_time: "2015-02-03T18:00:00-06:00" },
          "Tonight" => { predictions: { "Low Temperature" => "20",
                                        "Chance of Precipitation" => "99",
                                        "Conditions" => "Snow" },
                         start_time: "2015-02-03T18:00:00-06:00",
                         end_time: "2015-02-04T06:00:00-06:00" } }
      end
      let(:test_forecast) { NWS::Forecast.new("60606", test_periods) }
      let(:parser) { @parser ||= double("parser") }
      let(:service_url) { RestService::SERVICE_HOST + RestService::SERVICE_PATH }

      it "should return the forecast for a given zip code" do
        allow(DWMLParser).to receive(:new) { parser }
        expect(parser).to receive(:periods_with_predictions) { test_periods }
        request_stub = stub_request(:get, /#{Regexp.quote(service_url)}.*/).
          to_return(body: test_xml)
        forecast = RestService.forecast_by_zip_code("60606", days: 1)

        expect(request_stub).to have_been_requested
        expect(forecast).to eq(test_forecast)
      end
    end
  end
end
