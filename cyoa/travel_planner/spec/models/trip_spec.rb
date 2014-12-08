require 'rails_helper'

RSpec.describe Trip, type: :model do

  let(:ord) { FactoryGirl.create(:ord) }
  let(:lga) { FactoryGirl.create(:lga) }
  let(:meeting_lga) { FactoryGirl.create(:meeting_lga, location: lga.location) }
  let(:trip) do
    Trip.new(home_location: ord.location,
             meetings:      [meeting_lga])
  end

  let(:trip_optimizer_hash) do
    {
      from:           ord.code,
      to:             lga.code,
      meeting_start:  meeting_lga.start,
      meeting_length: meeting_lga.length,
    }
  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:trip)).to be_valid
  end

  it "requires home location" do
    expect { FactoryGirl.create(:trip, home_location: nil) }.to raise_error
  end

  it "can be converted to trip optimizer hash" do
    expect(trip.to_h).to eq(trip_optimizer_hash)
  end
end
