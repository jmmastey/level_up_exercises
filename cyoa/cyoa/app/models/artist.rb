class Artist < ActiveRecord::Base
  has_many :songs, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :grooveshark_id, uniqueness: true
  validates :nbs_id, uniqueness: true
end
