class Chart < ActiveRecord::Base
  belongs_to :service
  has_many :chart_songs
  has_many :songs, through: :chart_songs
  has_many :artists, through: :songs

  validates :scope, presence: true, inclusion: { in: %w(daily monthly) }

end
