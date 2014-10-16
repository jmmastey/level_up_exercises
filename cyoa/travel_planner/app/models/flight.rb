class Flight < ActiveRecord::Base
  belongs_to :destination_airport, class_name: "Airport"
  belongs_to :origin_airport, class_name: "Airport"

  has_and_belongs_to_many :trips
end
