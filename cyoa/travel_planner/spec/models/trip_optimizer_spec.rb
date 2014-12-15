require 'rails_helper'
require_relative '../../app/models/trip_optimizer'

describe 'TripOptimizer', vcr: { record: :once } do

  def expect_best_match(picked_flight, best_flight)
    expect(best_flight).to be
    expect(picked_flight).to eq(best_flight)
  end

  context 'Shortest Trip' do
    before(:context) do
      @meeting_start = "2014-12-15 13:00:09 UTC".to_datetime
      @now = "2014-12-10 13:00:09 UTC".to_datetime
    end

    let(:ord) { FactoryGirl.create(:ord) }
    let(:lga) { FactoryGirl.create(:lga) }
    let(:meeting_lga) do
      FactoryGirl.create(
        :meeting_lga,
        location: lga.location,
        start: @meeting_start,
      )
    end

    let(:trip) do
      Trip.new(home_location: ord.location,
               meetings:      [meeting_lga])
    end

    subject(:optimizer) do
      test_trip_h = trip.to_h
      test_trip_h[:now] = @now
      TripOptimizer.new(test_trip_h)
    end

    it 'given travel details, pick two flights' do
      expect(optimizer.best_departure).to be_valid
      expect(optimizer.best_return).to be_valid
    end

    it 'makes all departing flights available' do
      expect(optimizer.departures.length).to be > 0
    end

    it 'makes all returning flights available' do
      expect(optimizer.returns.length).to be > 0
    end

    it 'picks the best departing flight' do
      best = optimizer.departures.max_by(&:origin_date_time)
      expect_best_match(optimizer.best_departure, best)
    end

    it 'picks the best returning flight' do
      best = optimizer.returns.min_by(&:destination_date_time)
      expect_best_match(optimizer.best_return, best)
    end
  end
end
