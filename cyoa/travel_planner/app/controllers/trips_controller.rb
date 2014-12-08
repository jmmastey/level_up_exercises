class TripsController < ApplicationController
  def create
    @trip = create_trip
    redirect_to trip_flights_search_path(@trip.id)
  end

  def flights_search
    @trip = Trip.find(params[:trip_id])
    @optimizer = TripOptimizer.new(@trip.to_h)
    @optimizer.pick_shortest_flights
  end

  def flights_save
    # TODO: save the flights here. perhaps use flash? or session?
    redirect_to show
  end

  def show
    @trip = Trip.find(params[:trip_id])
  end

  private

  def create_trip
    location = Airport.find_by_code!(params[:origin_airport]).location
    Trip.create(home_location: location).tap do |trip|
      create_meeting(trip)
    end
  end

  def create_meeting(trip)
    trip.meetings.create(
      start:    datetime_from_select_inputs(params[:meeting], "start"),
      length:   params[:length],
      location: Airport.find_by_code!(params[:destination_airport]).location)
  end

  def datetime_from_select_inputs(form_param, object_attribute)
    DateTime.new(form_param["#{object_attribute}(1i)"].to_i,
      form_param["#{object_attribute}(2i)"].to_i,
      form_param["#{object_attribute}(3i)"].to_i,
      form_param["#{object_attribute}(4i)"].to_i,
      form_param["#{object_attribute}(5i)"].to_i)
  end
end
