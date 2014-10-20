class Forecast < ActiveRecord::Base
  validates_presence_of :forecast_request, :target_date
  belongs_to :forecast_request
end
