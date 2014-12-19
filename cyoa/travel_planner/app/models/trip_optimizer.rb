require 'flight_stats/schedule'
require 'active_support/all'

class TripOptimizer
  attr_accessor :from,
    :to,
    :meeting_start,
    :meeting_length

  def initialize(options = {})
    initialize_from_params(options)
    @flight_mapper ||= FlightMapper.new
    @schedule ||= FlightStats::Schedule.new
  end

  def departures
    @departures ||= begin
      flightstats = @schedule.flights_arriving_before(meeting_start, @from, @to, @now)
      map_flightstats_to_flights(flightstats)
    end
  end

  def returns
    @returns ||= begin
      flightstats = @schedule.flights_departing_after(meeting_end, @to, @from, @now)
      map_flightstats_to_flights(flightstats)
    end
  end

  def best_return
    @best_return ||= begin
      return unless returns
      returns.min_by(&:destination_date_time)
    end
  end

  def best_departure
    @best_departure ||= begin
      return unless departures
      departures.max_by(&:origin_date_time)
    end
  end

  private

  def initialize_from_params(options)
    @from           = options[:from]
    @to             = options[:to]
    @meeting_start  = options[:meeting_start]
    @meeting_length = options[:meeting_length]
    @now            = options[:now] || DateTime.now
  end

  def map_flightstats_to_flights(flightstats)
    flightstats.map do |f|
      Flight.new(@flight_mapper.flight_stats_to_flight_h(f))
    end
  end

  def meeting_end
    @meeting_start + @meeting_length.hours
  end
end
