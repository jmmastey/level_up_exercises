class Performance < ActiveRecord::Base
  belongs_to :show
  has_many :reviews, dependent: :destroy

  validates :performed_on, presence: true
  validates :show, presence: true

  scope :upcoming, -> { where("performed_on > ?", 1.month.ago).includes(:show) }

  def average_rating
    return unless reviews.any?

    total_rating = reviews.inject(0) do |total, review|
      total + review.rating
    end
    total_rating / reviews.length
  end

  def to_ical
    OpenStruct.new.tap do |e|
      e.dtstart       = Icalendar::Values::Date.new(performed_on)
      e.dtend         = Icalendar::Values::Date.new(performed_on + 1.day)
      e.summary       = show.name
      e.description   = show.description
      e.ip_class      = "PRIVATE"
    end
  end
end
