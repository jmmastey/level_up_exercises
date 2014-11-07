class Forecast < ActiveRecord::Base
  validates :date, uniqueness: true
end
