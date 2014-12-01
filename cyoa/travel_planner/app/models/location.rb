class Location < ActiveRecord::Base
  has_one :airport
  has_one :meeting
  has_many :trips

  validates_presence_of :address1, :city, :state, :postal_code
end
