require 'spec_helper'
require_relative '../../app/models/trip_optimizer'

describe 'TripOptimizer', :vcr do
  context 'Shortest Trip' do
    subject(:optimizer) do
      TripOptimizer.new({
        from: "ORD",
        to: "LGA",
        meeting_start: "2014-11-30T12:15:00.000".to_datetime,
        meeting_length: 1.5
      })
    end

    it 'given travel details, pick two flights' do
      expect(optimizer.pick_shortest_flights.length).to eq(2)
    end
  end
end
