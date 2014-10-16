class Location < ActiveRecord::Base
  has_one :airport
  has_one :meeting
  has_many :trips
end
