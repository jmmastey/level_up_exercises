class Forecast < ActiveRecord::Base
  validates_uniqueness_of :time, scope: :zip_code
end
