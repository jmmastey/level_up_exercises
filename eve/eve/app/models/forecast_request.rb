class ForecastRequest < ActiveRecord::Base
  belongs_to :item
  has_many :forecasts

  validates_presence_of :history_start_time, :history_end_time, :item, :num_target_days, :target_date
  validates_numericality_of :min_price, :average_price, :max_price,
    greater_than_or_equal_to: 0
end
