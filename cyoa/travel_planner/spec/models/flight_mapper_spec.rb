require 'rails_helper'

describe 'Map objects to Flight' do

  let(:origin_airport) { "LGA" }
  let(:origin_date_time) { "2014-12-01T13:00:00-05:00" }
  let(:destination_airport) { "ORD" }
  let(:destination_date_time) { "2014-12-01T14:43:00-06:00" }

  let(:flightstats) do
    {
      "carrierFsCode"           => "UA",
      "flightNumber"            => "681",
      "departureAirportFsCode"  => origin_airport,
      "arrivalAirportFsCode"    => destination_airport,
      "stops"                   => 0,
      "departureTerminal"       => "B",
      "arrivalTerminal"         => "1",
      "departureTime"           => "2014-12-01T13:00:00.000",
      "arrivalTime"             => "2014-12-01T14:43:00.000",
      "flightEquipmentIataCode" => "32S",
      "isCodeshare"             => false,
      "isWetlease"              => false,
      "serviceType"             => "J",
      "serviceClasses"          => %w(F J Y),
      "trafficRestrictions"     => [],
      "codeshares"              => [{ "carrierFsCode"       => "NH",
                                      "flightNumber"        => "7571",
                                      "serviceType"         => "J",
                                      "serviceClasses"      => %w(F J Y),
                                      "trafficRestrictions" => ["Q"],
                                      "referenceCode"       => "10709012" }],
      "referenceCode"           => "1192-1974462--",
      "arrivalTimeUtc"          => destination_date_time,
      "departureTimeUtc"        => origin_date_time,
    }
  end

  it 'should convert FlightStats to Flight' do
    flight_hash = FlightMapper.new.flight_stats_to_flight_h(flightstats)
    flight = Flight.new(flight_hash)
    expect(flight.origin_airport.code).to eq(origin_airport)
    expect(flight.origin_date_time).to eq(origin_date_time)
    expect(flight.destination_airport.code).to eq(destination_airport)
    expect(flight.destination_date_time).to eq(destination_date_time)
    expect(flight).to be_valid
  end
end
