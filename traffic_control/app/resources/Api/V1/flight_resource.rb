module Api
  module V1
    class FlightResource < JSONAPI::Resource
      has_one :plane
      has_many :passengers

      attributes :departure_time, :departure_airport, :arrival_time, :arrival_airport
      filters :departure_time, :departure_airport, :arrival_time, :arrival_airport
    end
  end
end
