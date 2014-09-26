class Event < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy
  has_many :event_dates, inverse_of: :event

  validates :name, presence: true, allow_blank: false
  validates :venue, presence: true
  validates :phone_number, phone: true

  validates_each(:price, :show_type, :phone_number, :running_time, :url, :ticket_url) do |param|
    validates param, allow_blank: true
  end

  validates_each(:event_url, :ticket_url) do |param|
    validates param, url: true
  end
end
