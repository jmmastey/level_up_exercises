class Legislator < ActiveRecord::Base
  has_many :good_deeds
  has_many :favorites
  has_many :users, through: :favorites
  default_scope -> { order(lastname: :asc) }
  validates :firstname, presence: true #, uniqueness: { case_sensitive: false }
  validates :lastname, presence: true
  validates :bioguide_id, presence: true, uniqueness: { case_sensitive: false }
  validates :party, presence: true
  validates :state, presence: true
  validates :birthdate, presence: true
end
