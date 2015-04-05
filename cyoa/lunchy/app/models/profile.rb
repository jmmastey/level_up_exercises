class Profile < ActiveRecord::Base
  belongs_to :user
  after_initialize :init
  validates :min_rating, presence: true, numericality: {
    greater_than_or_equal_to: 0.0, less_than_or_equal_to: 10.0 }
  validates :repeat_interval, presence: true, numericality: {
    greater_than: 0, less_than_or_equal_to: 31 }
  validates :max_distance, presence: true, numericality: {
    greater_than: 0, less_than_or_equal_to: 1200 }

  DEFAULT_REPEAT_INTERVAL = 5
  DEFAULT_MIN_RATING = 0.0
  DEFAULT_MAX_DISTANCE = 600

  def init
    self.repeat_interval ||= DEFAULT_REPEAT_INTERVAL
    self.min_rating ||= DEFAULT_MIN_RATING
    self.max_distance ||= DEFAULT_MAX_DISTANCE
  end
end
