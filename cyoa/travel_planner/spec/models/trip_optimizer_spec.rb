require 'rails_helper'
require_relative '../../app/models/trip_optimizer'

describe 'TripOptimizer', vcr: { record: :new_episodes } do

  def expect_best_match(picked_flight, best_flight)
    expect(best_flight).to be
    expect(picked_flight).to eq(best_flight)
  end

  context 'Shortest Trip' do

    let(:ord) { FactoryGirl.create(:ord) }
    let(:lga) { FactoryGirl.create(:lga) }
    let(:meeting_lga) do
      FactoryGirl.create(
        :meeting_lga,
        location: lga.location,
        start: "20141201T11:00:00-0500".to_datetime
      )
    end

    let(:trip) do
      Trip.new(home_location: ord.location,
               meetings:      [meeting_lga])
    end

    subject(:optimizer) do
      TripOptimizer.new(trip.to_optimizer_h)
    end

    def pick_shortest_flights(opti)
      VCR.use_cassette("trip_optimizer/pick_shortest_flights", { record: :new_episodes }) do
        opti.pick_shortest_flights
      end
    end

    it 'given travel details, pick two flights' do
      flights = pick_shortest_flights(optimizer)
      expect(flights.length).to eq(2)
      expect(flights[:departure]).to be
      expect(flights[:return]).to be
    end

    it 'makes all departing flights available' do
      pick_shortest_flights(optimizer)
      expect(optimizer.all_departures.length).to be > 0
    end

    it 'makes all returning flights available' do
      pick_shortest_flights(optimizer)
      expect(optimizer.all_returns.length).to be > 0
    end

    it 'picks the best departing flight' do
      pick_shortest_flights(optimizer)
      best = optimizer.all_departures.max_by do |f|
        f["departureTimeUtc"].to_datetime
      end
      expect_best_match(optimizer.departure, best)
    end

    it 'picks the best returning flight' do
      pick_shortest_flights(optimizer)
      best = optimizer.all_returns.min_by do |f|
        f["arrivalTimeUtc"].to_datetime
      end
      expect_best_match(optimizer.return, best)
    end
  end
end
