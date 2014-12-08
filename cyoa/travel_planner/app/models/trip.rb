class Trip < ActiveRecord::Base
  belongs_to :home_location, class_name: "Location"
  has_and_belongs_to_many :flights
  has_and_belongs_to_many :meetings

  validates_presence_of :home_location

  def to_h
    {
      from:           home_location.airport.code,
      to:             meetings[0].location.airport.code,
      meeting_start:  meetings[0].start,
      meeting_length: meetings[0].length,
    }
  end
end
