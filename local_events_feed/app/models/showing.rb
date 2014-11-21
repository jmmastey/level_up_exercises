class Showing < ActiveRecord::Base
  validates :time, presence: true
  validates :time, uniqueness: { scope: :event, message: 'unique within an event' }

  belongs_to :event
  delegate :name, :location, :link, :image, :description, :to => :event

  has_and_belongs_to_many :users

  scope :sorted, -> { order( :time => :asc ) }

  # to_ics
  def ics
    ical_event = Icalendar::Event.new
    ical_event.uid         = "#{id}"
    ical_event.dtstart     = time
    ical_event.summary     = name
    ical_event.location    = location
    ical_event.description = "#{name} at #{location}"
    ical_event.url         = link
    ical_event.ip_class    = "PRIVATE"
    ical_event
  end
end
