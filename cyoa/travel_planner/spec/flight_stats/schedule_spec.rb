require 'spec_helper'
require 'active_support/all'
require 'flight_stats/schedule'
require 'flight_stats/local_time'

describe 'FlightStats Schedules API', vcr: { record: :new_episodes } do
  include LocalTime

  let(:api) { FlightStats::Schedule.new }
  let(:origin) { "ORD" }
  let(:destination) { "LGA" }
  let(:destination_offset) { "-0500" }
  let(:meeting_start) do
    date = DateTime.parse(2.days.from_now.strftime("%FTT12:06:00"))
    strip_timezone(date)
  end
  let(:meeting_end) do
    date = DateTime.parse(2.days.from_now.strftime("%FTT13:06:00"))
    strip_timezone(date)
  end

  context 'api call gets flights' do
    subject(:flights) do
      api.get_flights_arriving_before(meeting_start, origin, destination)
    end

    it 'should show flights from chicago to new york tomorrow' do
      expect(flights).to_not be_empty
    end

    it 'flights should include UTC times for arrival and departure' do
      flights.each do |f|
        utc = f["arrivalTime"].to_datetime.change(offset: destination_offset)
        expect(f["arrivalTimeUtc"].to_datetime).to eq(utc)
      end
    end
  end

  context 'before meeting' do
    subject(:flights) do
      api.get_flights_arriving_before(meeting_start, origin, destination)
    end

    it 'flights exist' do
      expect(flights).not_to be_empty
    end

    it 'arrives before the meeting starts' do
      flights.each do |f|
        expect(f["departureTime"].to_datetime).to be < meeting_start
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

  context 'after meeting' do
    subject(:flights) do
      api.get_flights_departing_after(meeting_end, destination, origin)
    end

    it 'flights exist' do
      expect(flights).not_to be_empty
    end

    it 'departs after the meeting ends' do
      flights.each do |f|
        expect(f["departureTime"].to_datetime).to be > meeting_end
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
