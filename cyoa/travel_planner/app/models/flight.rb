class Flight < ActiveRecord::Base
  belongs_to :destination_airport, class_name: "Airport"
  belongs_to :origin_airport, class_name: "Airport"

  has_and_belongs_to_many :trips

  validates_presence_of :destination_airport,
    :destination_date_time,
    :origin_airport,
    :origin_date_time

end
