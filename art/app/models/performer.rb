class Performer < ActiveRecord::Base
  has_and_belongs_to_many :shows
  has_many :performances, through: :shows

  validates :name, presence: true
  validates :description, presence: true

  def average_rating
    sum = 0
    count = 0
    performances.each do |performance|
      performance.reviews.each do |review|
        count += 1
        sum += review[:rating]
      end
    end

    count.zero? ? nil : sum / count
  end
end
