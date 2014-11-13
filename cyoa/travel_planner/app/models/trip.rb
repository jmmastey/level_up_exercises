class Trip < ActiveRecord::Base
  belongs_to :home_location, class_name: "Location"
  has_and_belongs_to_many :flights
  has_and_belongs_to_many :meetings

  validates_presence_of :home_location

  # TODO: flight search here
end
