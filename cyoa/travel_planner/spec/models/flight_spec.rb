require 'rails_helper'

RSpec.describe Flight, type: :model do
  def create_with_nil(field)
    FactoryGirl.create(:flight, field => nil)
  end

  let(:origin_airport) { "ORD" }

  let(:flightstats_hash) do
    {
      carrierFsCode: "NK",
      flightNumber: "224",
      departureAirportFsCode: origin_airport,
      arrivalAirportFsCode: "LGA",
      stops: 0,
      departureTerminal: "3",
      arrivalTerminal: "B",
      departureTime: "2014-11-08T05:56:00.000",
      departureTimeUtc: "2014-11-08T05:56:00.000+0600",
      arrivalTime: "2014-11-08T09:00:00.000",
      arrivalTimeUtc: "2014-11-08T09:00:00.000+0500",
      flightEquipmentIataCode: "32S",
      isCodeshare: false,
      isWetlease: false,
      serviceType: "J",
      serviceClasses: ["R", "Y"],
      trafficRestrictions: [],
      codeshares: [],
      referenceCode: "1171-2493368--"
    }
  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:flight)).to be_valid
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

  it "can be built from a FlightStats flight hash" do
    flight = Flight.new(flightstats_hash)
    expect(flight.origin_airport).to eq(:origin_airport)
    expect(flight.origin_date_time).to eq(:origin_date_time)
    expect(flight.origin_date_time).to eq(:destination_airport)
    expect(flight.origin_date_time).to eq(:destination_date_time)
  end
end
