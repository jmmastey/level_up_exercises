require 'rspec'
require 'flight_stats/url_builder'

require 'active_support/all'

describe 'FlightStats Url Builder' do
  subject(:builder) { FlightStats::UrlBuilder.new }

  let(:schedule_base_url) { "https://api.flightstats.com/flex/schedules/rest/v1/json/" }
  let(:arriving_url) { "#{base_url}from/ORD/to/LGA/arriving/2014/11/09" }
  let(:departing_url) { "#{base_url}from/ORD/to/LGA/departing/2014/11/09" }

  context 'Schedule API Urls' do
    it 'arriving url' do
      builder.from("ORD").to("LGA").date("2014-11-09".to_datetime)
      expect(builder.schedule_arriving_url).to eq(arriving_url)
    end

    it 'departing url' do
      builder.from("ORD").to("LGA").date("2014-11-09".to_datetime)
      expect(builder.schedule_departing_url).to eq(departing_url)
    end

    it 'invalid url without from' do
      builder.to("LGA").date("2014-11-09".to_datetime)
      expect{ builder.schedule_arriving_url}.to raise_error(ArgumentError)
    end

    it 'invalid url without to' do
      builder.from("LGA").date("2014-11-09".to_datetime)
      expect{ builder.schedule_departing_url}.to raise_error(ArgumentError)
    end

    it 'invalid url without date' do
      builder.from("LGA").to("ORD")
      expect{ builder.schedule_departing_url}.to raise_error(ArgumentError)
    end
  end
end

