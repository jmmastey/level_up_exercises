class Watch < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  has_and_belongs_to_many :regions, as: :region_filters
  has_and_belongs_to_many :stations, as: :station_filters
end
