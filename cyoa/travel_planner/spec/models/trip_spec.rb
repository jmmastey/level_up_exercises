require 'rails_helper'

RSpec.describe Trip, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:trip)).to be_valid
  end

  it "requires home location" do
    expect { FactoryGirl.create(:trip, home_location: nil) }.to raise_error
  end
end
