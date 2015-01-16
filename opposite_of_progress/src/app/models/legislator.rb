class Legislator < ActiveRecord::Base
  # validates :bioguide_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :title, presence: true, inclusion: { in: %w(Sen Rep Del Com) }
  validates :party, presence: true
  validates :state, presence: true
  validates :chamber, presence: true
  validates :state_rank, presence: true, inclusion: { in: %w(senior junior) },
              if: :senator?
  validates :district, presence: true, numericality: { only_integer: true },
              if: :representative?

  has_many :good_deeds
  has_many :sponsorships,  -> { where action: 'sponsored' }, class_name: 'GoodDeed'
  has_many :cosponsorships, -> { where action: 'cosponsored' }, class_name: 'GoodDeed'

  TITLES = {
    'Rep' => 'Representative',
    'Del' => 'Delegate',
    'Sen' => 'Senator',
  }

  PARTIES = {
    'R' => 'Republican',
    'D' => 'Democratic',
    'I' => 'Independent',
  }

  def senator?
    chamber == 'senate'
  end

  def representative?
    chamber == 'house'
  end

  def name
    middle_initial = middle_name ? "#{middle_name[0, 1]}." : nil
    [first_name, middle_initial, last_name, name_suffix].compact.join(" ")
  end

  def name_with_title
    [title, name].join('. ')
  end

  def long_title
    TITLES[title]
  end

  def long_party
    PARTIES[party]
  end

  def readable_district
    district.zero? ? 'At-Large' : district.ordinalize
  end
end
