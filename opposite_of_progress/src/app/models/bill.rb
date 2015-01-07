class Bill < ActiveRecord::Base
  validates :bill_type, presence: true
  validates :chamber, presence: true, inclusion: { in: %w(senate house) }
  validates :official_title, presence: true
  # belongs_to :sponsor, class_name: 'Legislator'
  # has_many :cosponsorships
  # has_many :cosponsors, through: :cosponsorships, source: :legislator
end
