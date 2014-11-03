class Metric < ActiveRecord::Base
  belongs_to :artist
  belongs_to :service
  belongs_to :category

  validates :artist, :service, :value, :category, :nbs_date, :recorded_on, presence: true

  before_create :set_recorded_on

  def unix_time
    recorded_on.to_time.to_i
  end

  private

  def set_recorded_on
    sec_in_day = 86400
    date_unix_days = nbs_date.to_i
    date_unix_sec = date_unix_days * sec_in_day
    self.recorded_on = Time.at(date_unix_sec).utc
  end
end
