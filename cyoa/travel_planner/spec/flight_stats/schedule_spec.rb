require "faker"
require "spec_helper"
require "active_support/all"
require "flight_stats/schedule"

describe 'FlightStats Schedules API' do

  let(:api) { FlightStats::Schedule.new }
  let(:origin) { "ORD" }
  let(:destination) { "LGA" }
  let(:destination_offset) { "-0500" }

  let(:meeting_day) { DateTime.new(2014, 12, 25).change(offset: destination_offset) }
  let(:early_start) { meeting_day + 4.hours }
  let(:meeting_start) { meeting_day + 10.hours }
  let(:meeting_end) { meeting_day + 12.hours }
  let(:late_meeting_end) { (meeting_day + 23.hours + 59.minutes).change(offset: destination_offset) }

  context 'api call gets flights', vcr: { record: :new_episodes } do
    subject(:flights) do
      api.flights_arriving_before(
        dynamic_meeting_start,
        origin,
        destination)
    end

    let(:tomorrow_morning) do
      date = 1.days.from_now
      date = DateTime.new(date.year, date.month, date.day)
      date + 1.hours
    end

    let(:dynamic_meeting_start) do
      Faker::Time.between(5.days.from_now, 10.days.from_now, :morning)
    end

    let(:past_date) { -10.days.from_now }

    it 'throws an error when a past date is requested for arriving before' do
      expect { api.flights_arriving_before(
        past_date,
        origin,
        destination) }.to raise_error(ArgumentError)
    end

    it 'throws an error when a past date is requested for departing after' do
      expect { api.flights_departing_after(
        past_date,
        origin,
        destination) }.to raise_error(ArgumentError)
    end

    it 'throws an error when tomorrows flight is not early enough, and has to search today' do
      expect { api.flights_arriving_before(
        tomorrow_morning,
        origin,
        destination) }.to raise_error(ArgumentError)
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

  context 'before meeting', vcr: { record: :once } do
    subject(:flights) do
      api.flights_arriving_before(meeting_start, origin, destination)
    end

    let(:early_flights) do
      api.flights_arriving_before(early_start, origin, destination)
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

  context 'after meeting', vcr: { record: :once } do
    subject(:flights) do
      api.flights_departing_after(meeting_end, destination, origin)
    end

    let(:late_flights) do
      puts late_meeting_end
      api.flights_departing_after(late_meeting_end, origin, destination)
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

    it 'late flights exist' do
      expect(late_flights).not_to be_empty
    end

    it 'uses next day returns when the meeting is super late' do
      late_flights.each do |f|
        expect(f["departureTimeUtc"].to_datetime).to be > late_meeting_end
      end
    end
  end
end
