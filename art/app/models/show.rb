class Show < ActiveRecord::Base
  has_and_belongs_to_many :performers
  has_many :performances, dependent: :destroy
  has_many :reviews, through: :performances

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :year, presence: true, numericality: true
  validates :director, presence: true
  validates :theatre_company, presence: true
  validates :notes, presence: true

  default_scope -> { order("name asc") }

  def self.trending(limit = 5)
    find(recently_reviewed(limit))
  end

  def self.recently_reviewed(limit)
    connection.execute("select distinct show_id from (
      select show_id from reviews
        join performances on performances.id = reviews.performance_id
        join shows on shows.id = performances.show_id
      order by reviews.created_at desc
      ) t limit #{limit}").map { |s| s['show_id'] }
  end

  def num_reviews
    Review.where(performance: performances).count
  end
end
