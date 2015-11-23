class Flight < ActiveRecord::Base
  belongs_to :plane
  has_and_belongs_to_many :passengers
end
