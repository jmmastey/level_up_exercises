class Trip < ActiveRecord::Base
  belongs_to :home_location, class_name: "Location"
  has_and_belongs_to_many :flights
  has_and_belongs_to_many :meetings

  validates_presence_of :home_location

  def to_h
    {
      from:           airport_code(home_location.id),
      to:             airport_code(meetings[0].location.id),
      meeting_start:  meetings[0].start,
      meeting_length: meetings[0].length,
    }
  end

  private

  def airport_code(location_id)
    Airport.find_by!(location: location_id).code
  end
end
