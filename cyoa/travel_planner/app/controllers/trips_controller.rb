class TripsController < ApplicationController
  def create
    @trip = create_trip
    redirect_to trip_flights_search_path(@trip.id)
  end

  def flights_search
    @trip = Trip.find(params[:trip_id])
    #load it up
    @optimizer = TripOptimizer.new(@trip.to_optimizer_h)
    @optimizer.pick_shortest_flights

    #@trip.flights = [Flight.new(@picked_flights[:departure]), Flight.new(@picked_flights[:return])]

    #show the shit here
  end

  private

  def create_trip
    trip = Trip.new
    trip.home_location = Airport.find_by_code!(params[:origin_airport]).location
    trip.save
    create_meeting(trip)
    trip
  end

  def create_meeting(trip)
    trip.meetings.create(
      start:    datetime_from_select_inputs(params[:meeting], "start"),
      length:   params[:length],
      location: Airport.find_by_code!(params[:destination_airport]).location)
  end

  def datetime_from_select_inputs(param, method)
    DateTime.new(param["#{method}(1i)"].to_i,
      param["#{method}(2i)"].to_i,
      param["#{method}(3i)"].to_i,
      param["#{method}(4i)"].to_i,
      param["#{method}(5i)"].to_i)
  end
end
