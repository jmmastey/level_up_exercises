class Meeting < ActiveRecord::Base
  belongs_to :location
  has_and_belongs_to_many :trips

  validates_presence_of :start, :length, :location
end
