require "faker"
require "spec_helper"
require "active_support/all"
require "flight_stats/schedule"

describe 'FlightStats Schedules API' do

  let(:api) { FlightStats::Schedule.new }
  let(:origin) { "ORD" }
  let(:destination) { "LGA" }
  let(:destination_offset) { "-0500" }
  let(:meeting_start) { "2014-12-27T12:00:00-05:00".to_datetime }
  let(:early_start) { "2014-12-27T04:00:00-05:00".to_datetime }
  let(:meeting_end) { "2014-12-27T13:00:00-05:00".to_datetime }
  let(:dynamic_meeting_start) { Faker::Time.forward(10, :morning).to_datetime  }

  context 'api call gets flights (api call daily)' do
    subject(:flights) do
      VCR.use_cassette("schedule/api_call_gets_flights",
        record: :new_episodes) do
        api.get_flights_arriving_before(
          dynamic_meeting_start,
          origin,
          destination)
      end
    end

    it 'api response should not be empty' do
      expect(flights).to_not be_empty
    end

    it 'flights should include UTC times for arrival and departure' do
      flights.each do |f|
        utc = f["arrivalTime"].to_datetime.change(offset: destination_offset)
        expect(f["arrivalTimeUtc"].to_datetime).to eq(utc)
      end
    end
  end

  context 'before meeting (pre-recorded API)' do
    subject(:flights) do
      VCR.use_cassette("schedule/get_flights_arriving_before", record: :new_episodes) do
        api.get_flights_arriving_before(meeting_start, origin, destination)
      end
    end

    let(:early_flights) do
      VCR.use_cassette("schedule/get_flights_arriving_before_early", record: :new_episodes) do
        api.get_flights_arriving_before(early_start, origin, destination)
      end
    end

    it 'flights exist' do
      expect(flights).not_to be_empty
    end

    it 'arrives before the meeting starts' do
      flights.each do |f|
        expect(f["arrivalTimeUtc"].to_datetime).to be < meeting_start
      end
    end

    it 'uses previous day departures when the meeting is super early' do
      early_flights.each do |f|
        expect(f["arrivalTimeUtc"].to_datetime).to be < early_start
      end
    end

    it 'departs from my origin' do
      flights.each do |f|
        expect(f["departureAirportFsCode"]).to eq(origin)
      end
    end

    it 'arrives at my destination' do
      flights.each do |f|
        expect(f["arrivalAirportFsCode"]).to eq(destination)
      end
    end
  end

  context 'after meeting (pre-recorded API)' do
    subject(:flights) do
      VCR.use_cassette("schedule/get_flights_departing_after", record: :new_episodes) do
        api.get_flights_departing_after(meeting_end, destination, origin)
      end
    end

    it 'flights exist' do
      expect(flights).not_to be_empty
    end

    it 'departs after the meeting ends' do
      flights.each do |f|
        expect(f["departureTimeUtc"].to_datetime).to be > meeting_end
      end
    end

    it 'departs from my destination' do
      flights.each do |f|
        expect(f["departureAirportFsCode"]).to eq(destination)
      end
    end

    it 'arrives at my origin' do
      flights.each do |f|
        expect(f["arrivalAirportFsCode"]).to eq(origin)
      end
    end
  end
end
