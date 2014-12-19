class Trip < ActiveRecord::Base
  belongs_to :home_location, class_name: "Location"
  has_and_belongs_to_many :flights
  has_and_belongs_to_many :meetings

  validates_presence_of :home_location

  def to_h
    {
      from:           home_location.airport.code,
      to:             meetings.first.location.airport.code,
      meeting_start:  meetings.first.start,
      meeting_length: meetings.first.length,
    }
  end
end
