class EventSource < ActiveRecord::Base
  has_many :calendar_events
  has_and_belongs_to_many :feeds
end
