class GoodDeed < ActiveRecord::Base
  belongs_to :legislator
  default_scope -> { order(introduced_on: :desc) }
  validates :congress_number, presence: true
  validates :congress_url, presence: true, uniqueness: { case_sensitive: false }
  validates :short_title, presence: true, uniqueness: { case_sensitive: false }
  validates :official_title, presence: true, uniqueness: { case_sensitive: false }
  validates :introduced_on, presence: true
  validates :legislator_id, presence: true

  def self.by_party(party)
    joins(:legislator).where(legislators: { party: party })
  end

  def self.to_json
    all.to_json
  end
end
