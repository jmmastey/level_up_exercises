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

  def initialize(options={})
    @from           = options[:from]
    @to             = options[:to]
    @meeting_start  = options[:meeting_start]
    @meeting_length = options[:meeting_length]
    @schedule        = FlightStats::Schedule.new
  end

  def pick_shortest_flights
    @all_departures = get_departures(@meeting_start, @from, @to)
    @all_returns = get_returns(meeting_end, @to, @from)

    @departure = get_latest_departure(@all_departures)
    @return = get_earliest_arrival(@all_returns)

    get_departure_and_return
  end

  private

  def get_departures(meeting_start, from, to)
    @schedule.get_flights_arriving_before(meeting_start, from, to)
  end

  def get_returns(meeting_end, from, to)
    @schedule.get_flights_departing_after(meeting_end, from, to)
  end

  def get_departure_and_return
    {
      departure: @departure,
      return:    @return
    }
  end

  def get_earliest_arrival(flights)
    flights.min_by do |f|
      f["arrivalTimeUtc"].to_datetime
    end
  end

  def get_latest_departure(flights)
    flights.max_by do |f|
      f["departureTimeUtc"].to_datetime
    end
  end

  def meeting_end
    @meeting_start + @meeting_length.hours
  end
end