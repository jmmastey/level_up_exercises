require 'flight_stats/schedule'
require 'active_support/all'

class TripOptimizer
  attr_accessor :from,
    :to,
    :meeting_start,
    :meeting_length,
    :all_departures,
    :all_returns,
    :departure,
    :return

  def initialize(options = {})
    @flight_mapper = FlightMapper.new
    @schedule = FlightStats::Schedule.new
    initialize_from_params(options)
  end

  def pick_shortest_flights
    @all_departures = get_departures(@meeting_start, @from, @to)
    @all_returns    = get_returns(meeting_end, @to, @from)

    @departure = get_latest_departure(@all_departures)
    @return    = get_earliest_arrival(@all_returns)

    departure_and_return
  end

  private

  def initialize_from_params(options)
    @from           = options[:from]
    @to             = options[:to]
    @meeting_start  = options[:meeting_start]
    @meeting_length = options[:meeting_length]
  end

  def get_departures(meeting_start, from, to)
    flightstats = @schedule.get_flights_arriving_before(meeting_start, from, to)
    map_flightstats_to_flights(flightstats)
  end

  def map_flightstats_to_flights(flightstats)
    flights = []
    flightstats.each do |f|
      flights.push(Flight.new(@flight_mapper.flight_stats_to_flight_h(f)))
    end
    flights
  end

  def get_returns(meeting_end, from, to)
    flightstats = @schedule.get_flights_departing_after(meeting_end, from, to)
    map_flightstats_to_flights(flightstats)
  end

  def departure_and_return
    {
      departure: @departure,
      return:    @return,
    }
  end

  def get_earliest_arrival(flights)
    return unless flights
    flights.min_by(&:destination_date_time)
  end

  def get_latest_departure(flights)
    return unless flights
    flights.max_by(&:origin_date_time)
  end

  def meeting_end
    @meeting_start + @meeting_length.hours
  end
end
