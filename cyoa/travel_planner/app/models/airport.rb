class Airport < ActiveRecord::Base
  has_one :destination_flight, class_name: "Flight", foreign_key: "destination_airport_id"
  has_one :origin_flight, class_name: "Flight", foreign_key: "origin_airport_id"
  belongs_to :origin_airport, class_name: "Airport"

  belongs_to :location
end
