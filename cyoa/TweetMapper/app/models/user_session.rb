require 'upsert/active_record_upsert'

class UserSession < ActiveRecord::Base
  validates :session_key, presence: true, uniqueness: true
  validates :last_activity, presence: true, timeliness: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :miles_radius, presence: true, numericality: true

  before_validation { self.last_activity = Time.now }
end
