class FlightMapper
  def flight_stats_to_flight_h(flightstats)
    flight = {}
    lookup_airports(flight, flightstats)
    set_times(flight, flightstats)
    flight
  end

  private

  def lookup_airports(flight, flightstats)
    airport                       = Airport.find_by_code!(flightstats["departureAirportFsCode"])
    flight["origin_airport"]      = airport
    airport                       = Airport.find_by_code!(flightstats["arrivalAirportFsCode"])
    flight["destination_airport"] = airport
  end

  def set_times(flight, flightstats)
    flight["origin_date_time"]      = flightstats["departureTimeUtc"]
    flight["destination_date_time"] = flightstats["arrivalTimeUtc"]
  end
end
