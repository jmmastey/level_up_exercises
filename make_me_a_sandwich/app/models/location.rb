class Location < ActiveRecord::Base
  scope :with_city_state, -> (city, state) { where(city: city, state: state) }
  scope :with_zip, -> (zip) { where(zip: zip) }
end
