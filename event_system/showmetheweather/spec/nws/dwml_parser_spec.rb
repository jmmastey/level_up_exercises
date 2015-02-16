require "spec_helper"
require "nws/dwml_parser"

module NWS
  describe DWMLParser do
    describe "#periods_with_predictions" do
      let(:test_xml) { File.read(File.expand_path("../test.xml", __FILE__)) }
      let(:test_periods) do
        { "Today" => { predictions: { "High Temperature" => "24",
                                      "Chance of Precipitation" => "82" },
                       start_time: "2015-02-03T06:00:00-06:00",
                       end_time: "2015-02-03T18:00:00-06:00" },
          "Tonight" => { predictions: { "Low Temperature" => "20",
                                        "Chance of Precipitation" => "99",
                                        "Conditions" => "Snow" },
                         start_time: "2015-02-03T18:00:00-06:00",
                         end_time: "2015-02-04T06:00:00-06:00" } }
      end

      it "should return a hash of periods with predictions" do
        parser = DWMLParser.new(test_xml)

        expect(parser.periods_with_predictions).to eq(test_periods)
      end
    end
  end
end
