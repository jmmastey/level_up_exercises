require 'rails_helper'

RSpec.describe Flight, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:flight)).to be_valid
  end

  it "requires destination airport" do
    expect { FactoryGirl.create(:flight, destination_airport: nil) }.to raise_error
  end

  it "requires destination time" do
    expect { FactoryGirl.create(:flight, destination_date_time: nil) }.to raise_error
  end

  it "requires origin airport" do
    expect { FactoryGirl.create(:flight, origin_airport: nil) }.to raise_error
  end

  it "requires origin time" do
    expect { FactoryGirl.create(:flight, origin_date_time: nil) }.to raise_error
  end
end
