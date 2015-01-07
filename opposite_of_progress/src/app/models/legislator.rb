class Legislator < ActiveRecord::Base
  validates :bioguide_id, presence: true, uniqueness: true
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

  # has_many :sponsored_bills, class_name: 'Bill', foreign_key: 'sponsor_id'
  # has_many :cosponsorships
  # has_many :cosponsored_bills, through: :cosponsorships, source: :bill

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

  def representation
    "#{party}-#{state}"
  end
end
