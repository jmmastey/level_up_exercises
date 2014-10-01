class Event < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy
  has_many :event_dates, inverse_of: :event

  validates :name, presence: true, allow_blank: false
  validates :venue, presence: true
  validates :price, presence: true, allow_blank: true
  validates :show_type, presence: true, allow_blank: true
  validates :phone_number, presence: true, allow_blank: true
  validates :running_time, presence: true, allow_blank: true
  validates :event_url, presence: true, allow_blank: true, url: true
  validates :ticket_url, presence: true, allow_blank: true, url: true

  # validates_each(:price, :show_type, :phone_number, :running_time,
  # :event_url, :ticket_url) do |param|
  #   validates param.to_param, allow_blank: true
  # end
  #
  # validates_each(:event_url, :ticket_url) do |param|
  #   validates param.to_param, url: true
  # end
end
