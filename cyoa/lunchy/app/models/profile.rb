class Profile < ActiveRecord::Base
  belongs_to :user
  after_initialize :init

  DEFAULT_REPEAT_INTERVAL = 5
  DEFAULT_MIN_RATING = 0.0
  DEFAULT_MAX_DISTANCE = 600

  def init
    self.repeat_interval ||= DEFAULT_REPEAT_INTERVAL
    self.min_rating ||= DEFAULT_MIN_RATING
    self.max_distance ||= DEFAULT_MAX_DISTANCE
  end
end
