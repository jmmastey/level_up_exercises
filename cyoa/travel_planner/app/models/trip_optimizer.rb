require 'flight_stats/schedule'
require 'active_support/all'

class TripOptimizer
  attr_accessor :from, :to, :meeting_start, :meeting_length

  def initialize(options={})
    @from = options[:from]
    @to = options[:to]
    @meeting_start = options[:meeting_start]
    @meeting_length = options[:meeting_length]
  end

  def pick_shortest_flights
    schedule = FlightStats::Schedule.new
    arriving = schedule.get_flights_arriving_before(@meeting_start, @from, @to)
    departing = schedule.get_flights_departing_after(meeting_end, @to, @from)

    [arriving[0], departing[0]]
  end

  def meeting_end
    @meeting_start + @meeting_length.hours
  end
end