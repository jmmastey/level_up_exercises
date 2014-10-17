class Region < ActiveRecord::Base
  has_one :location, as: :locatable
  has_many :orders, dependent: :destroy
end
