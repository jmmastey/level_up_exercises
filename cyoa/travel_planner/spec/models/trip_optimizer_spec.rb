require 'rails_helper'
require_relative '../../app/models/trip_optimizer'

describe 'TripOptimizer', vcr: { record: :new_episodes } do
  context 'Shortest Trip' do

    let(:ord) { FactoryGirl.create(:ord) }
    let(:lga) { FactoryGirl.create(:lga) }
    let(:meeting_lga) { FactoryGirl.create(:meeting_lga, location: lga.location) }
    let(:trip) do
      Trip.new(home_location: ord.location,
               meetings:      [meeting_lga])
    end

    subject(:optimizer) do
      TripOptimizer.new(trip.to_optimizer_h)
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
