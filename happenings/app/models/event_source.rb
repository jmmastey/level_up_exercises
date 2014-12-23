class EventSource < ActiveRecord::Base
  lookup_by :event_source, cache: true, raise: true
  has_many :events
  validates :event_source, uniqueness: true
end
