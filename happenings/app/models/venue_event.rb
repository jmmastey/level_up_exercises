class VenueEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :event_date
end
