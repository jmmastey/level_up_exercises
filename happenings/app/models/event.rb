class Event < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy
  has_many :event_dates, inverse_of: :event

  default_scope -> {order(name: :asc)}
  default_scope -> {includes(:event_dates).all}
  scope :index, -> { includes(:event_dates).all.limit(20) }

  validates :name, presence: true, allow_blank: false
  validates :venue, presence: true
  validates :price, presence: true, allow_blank: true
  validates :show_type, presence: true, allow_blank: true
  validates :phone_number, presence: true, allow_blank: true
  validates :running_time, presence: true, allow_blank: true
  validates :event_url, presence: true, allow_blank: true, url: true
  validates :ticket_url, presence: true, allow_blank: true, url: true
end
