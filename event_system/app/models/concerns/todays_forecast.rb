module TodaysForecast
  extend ActiveSupport::Concern

  included do
    scope :today, -> { where( "created_at::date = ?", Time.now.utc.to_date ) }
  end
end
