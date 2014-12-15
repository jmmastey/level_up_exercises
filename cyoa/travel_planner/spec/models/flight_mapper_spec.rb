require 'rails_helper'

describe 'Map objects to Flight' do

  subject(:flight) do
    flight_hash = FlightMapper.new.flight_stats_to_flight_h(flightstats)
    Flight.new(flight_hash)
  end

  let(:origin_airport) { "LGA" }
  let(:origin_date_time) { "2014-12-01T13:00:00-05:00" }
  let(:destination_airport) { "ORD" }
  let(:destination_date_time) { "2014-12-01T14:43:00-06:00" }
  let(:flight_number) { "681" }
  let(:carrier) { "UA" }

  let(:flightstats) do
    {
      "carrierFsCode"           => carrier,
      "flightNumber"            => flight_number,
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

  it 'convert FlightStats to Flight' do
    expect(flight).to be_valid
  end

  it 'has correct origin_airport' do
    expect(flight.origin_airport.code).to eq(origin_airport)
  end

  it 'has correct origin_date_time' do
    expect(flight.origin_date_time).to eq(origin_date_time)
  end

  it 'has correct destination_airport' do
    expect(flight.destination_airport.code).to eq(destination_airport)
  end

  it 'has correct destination_date_time' do
    expect(flight.destination_date_time).to eq(destination_date_time)
  end

  it 'has correct flight_number' do
    expect(flight.flight_number).to eq(flight_number)
  end

  it 'has correct carrier' do
    expect(flight.carrier).to eq(carrier)
  end
end
