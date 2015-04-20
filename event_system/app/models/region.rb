class Region < ActiveRecord::Base
  scope :region_id,  ->(city_name) { where('city = ?', city_name) }
end
