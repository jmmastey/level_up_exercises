class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :performance

  validates :user, presence: true
  validates :performance, presence: true
  validates :rating, presence: true, numericality: true

  scope :recent, -> { where("created_at > ?", 5.days.ago) }
  scope :for, ->(performance) { where(performance: performance) }

  def self.recent_ratings(performance)
    recent.for(performance).average(:rating)
  end

  def sentiment
    recent = self.class.recent_ratings(self.performance)

    if self.rating > (recent + 0.5)
      :happy
    elsif self.rating < (recent - 0.5)
      :sad
    else
      :meh
    end
  end
end
