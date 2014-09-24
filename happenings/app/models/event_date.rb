class EventDate < ActiveRecord::Base
  belongs_to :venue
  belongs_to :event
end
