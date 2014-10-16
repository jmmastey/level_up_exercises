class Trip < ActiveRecord::Base
  belongs_to :location
  has_and_belongs_to_many :flights
  has_and_belongs_to_many :meetings
end
