class Showing < ActiveRecord::Base
  validates :time, presence: true
  validates :time, uniqueness: { scope: :event, message: 'unique within an event' }

  belongs_to :event
  delegate :name, :location, :link, :image, :description, :to => :event

  has_and_belongs_to_many :users

  scope :sorted, -> { order( :time => :asc ) }

  def to_ics
    Icalendar::Event.new.tap do |ical_event|
      ical_event.uid         = id
      ical_event.dtstart     = time
      ical_event.summary     = name
      ical_event.location    = location
      ical_event.description = "#{name} at #{location}"
      ical_event.url         = link
      ical_event.ip_class    = "PRIVATE"
    end
  end
end
