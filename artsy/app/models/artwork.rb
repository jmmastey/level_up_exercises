class Artwork < ActiveRecord::Base
  belongs_to :artist

  validates :title, :date, presence: true

  paginates_per 5
end
