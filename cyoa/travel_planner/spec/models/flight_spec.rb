require 'rails_helper'

RSpec.describe Flight, type: :model do
  def create_with_nil(field)
    FactoryGirl.create(:flight, field => nil)
  end

  it "requires destination airport" do
    expect { create_with_nil(:destination_airport) }.to raise_error
  end

  it "requires destination time" do
    expect { create_with_nil(:destination_date_time) }.to raise_error
  end

  it "requires origin airport" do
    expect { create_with_nil(:origin_airport) }.to raise_error
  end

  it "requires origin time" do
    expect { create_with_nil(:origin_date_time) }.to raise_error
  end

  it "requires carrier code" do
    expect { create_with_nil(:carrier) }.to raise_error
  end

  it "requires flight number" do
    expect { create_with_nil(:flight_number) }.to raise_error
  end

  it "key is made of carrier+flight" do
    flight = FactoryGirl.create(:flight, carrier: "AA", flight_number: "123")
    expect(flight.key).to eql("AA123")
  end

end
