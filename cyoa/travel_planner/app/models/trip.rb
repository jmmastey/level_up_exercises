class Trip < ActiveRecord::Base
  belongs_to :home_location, class_name: "Location"
  has_and_belongs_to_many :flights
  has_and_belongs_to_many :meetings

  validates_presence_of :home_location

  def to_optimizer_h
    { from:           airport_code(self.home_location.id),
      to:             airport_code(self.meetings[0].location.id),
      meeting_start:  self.meetings[0].start,
      meeting_length: self.meetings[0].length }
  end

  private

  def airport_code(location_id)
    Airport.find_by!(location: location_id).code
  end

end
