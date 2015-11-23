class PlaneComponent < ActiveRecord::Base
  belongs_to :plane
  belongs_to :component
end
