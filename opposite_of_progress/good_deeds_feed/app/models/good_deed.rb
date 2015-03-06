class GoodDeed < ActiveRecord::Base
  after_create :send_email_notification

  belongs_to :legislator
  default_scope -> { order(introduced_on: :desc) }
  scope :to_json, -> { all.to_json }
  validates :congress_number, presence: true
  validates :congress_url, presence: true, uniqueness: { case_sensitive: false }
  validates :short_title, presence: true, uniqueness: { case_sensitive: false }
  validates :official_title,  presence: true,
                              uniqueness: { case_sensitive: false }
  validates :introduced_on, presence: true
  validates :legislator_id, presence: true

  def self.by_party(party)
    joins(:legislator).where(legislators: { party: party })
  end

  def send_email_notification
    GoodDeedsMailer.new_deed_notification(self).deliver
  end
end
