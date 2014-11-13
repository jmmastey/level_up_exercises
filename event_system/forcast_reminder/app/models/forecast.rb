class Forecast < ActiveRecord::Base
  validates_uniqueness_of :date, scope: :zip_code
end
