class Performance < ActiveRecord::Base
  belongs_to :show
  has_many :reviews, dependent: :destroy

  validates :performed_on, presence: true
  validates :show, presence: true

  def average_rating
    return unless reviews.any?

    total_rating = reviews.inject(0) do |total, review|
      total + review.rating
    end
    total_rating / reviews.length
  end
end
