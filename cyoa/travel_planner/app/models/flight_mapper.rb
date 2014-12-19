class FlightMapper
  def flight_stats_to_flight_h(flightstats)
    Hash.new.tap do |flight|
      lookup_airports(flight, flightstats)
      set_times(flight, flightstats)
      flight["carrier"] = flightstats["carrierFsCode"]
      flight["flight_number"] = flightstats["flightNumber"]
    end
  end

  private

  def lookup_airports(flight, flightstats)
    flight["origin_airport"] = origin_airport(flightstats)
    flight["destination_airport"] = destination_airport(flightstats)
  end

  def destination_airport(flightstats)
    Airport.find_by_code!(flightstats["arrivalAirportFsCode"])
  end

  def origin_airport(flightstats)
    Airport.find_by_code!(flightstats["departureAirportFsCode"])
  end

  def set_times(flight, flightstats)
    flight["origin_date_time"]      = flightstats["departureTimeUtc"]
    flight["destination_date_time"] = flightstats["arrivalTimeUtc"]
  end
end
