class Plane < ActiveRecord::Base
  belongs_to :plane_type
  has_many :flights
  has_many :plane_components
end
