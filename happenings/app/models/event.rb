class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :event_dates
end
