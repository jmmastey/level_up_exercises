class Song < ActiveRecord::Base
  belongs_to :artist

  validates :artist, presence: true
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false, scope: :artist }
  validates :grooveshark_id, uniqueness: true
end
