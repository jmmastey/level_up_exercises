class Bill < ActiveRecord::Base
  validates :bill_type, presence: true
  validates :chamber, presence: true, inclusion: { in: %w(senate house) }
  validates :official_title, presence: true
  has_many :good_deeds
  has_many :actions, -> { where action: %w(voted enacted) }, class_name: 'GoodDeed'
  has_many :sponsorships,  -> { where action: 'sponsored' }, class_name: 'GoodDeed'
  has_many :cosponsorships, -> { where action: 'cosponsored' }, class_name: 'GoodDeed'

  def title_with_id
    "#{official_id.upcase}: #{official_title}"
  end
end
