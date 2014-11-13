require 'spec_helper'
require_relative '../../app/models/trip_optimizer'

describe 'TripOptimizer', :vcr do
  context 'Shortest Trip' do
    subject(:optimizer) do
      TripOptimizer.new(
        from:           "ORD",
        to:             "LGA",
        meeting_start:  "2014-11-30T12:15:00.000".to_datetime,
        meeting_length: 1.5,
      )
    end

    it 'given travel details, pick two flights' do
      expect(optimizer.pick_shortest_flights.length).to eq(2)
    end

    it 'makes all departing flights available' do
      optimizer.pick_shortest_flights
      expect(optimizer.all_departures.length).to be > 0
    end

    it 'makes all returning flights available' do
      optimizer.pick_shortest_flights
      expect(optimizer.all_returns.length).to be > 0
    end

    it 'picks the best departing flight' do
      optimizer.pick_shortest_flights
      best = optimizer.all_departures.max_by do |f|
        f["departureTimeUtc"].to_datetime
      end
      expect(optimizer.departure).to eq(best)
    end

    it 'picks the best returning flight' do
      optimizer.pick_shortest_flights
      best = optimizer.all_returns.min_by do |f|
        f["arrivalTimeUtc"].to_datetime
      end
      expect(optimizer.return).to eq(best)
    end
  end
end
