class Artwork < ActiveRecord::Base
  belongs_to :artist

  validates :title, :date, presence: true
end
