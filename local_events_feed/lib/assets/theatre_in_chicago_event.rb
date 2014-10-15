require 'date'
require 'active_support/all'

class TheatreInChicagoEvent
  attr_accessor :name, :location, :date, :time, :link

  def initialize(date)
    @date = date
    @name = ''
    @location = ''
    @time = ''
    @link = ''
  end

  def complete?
    date.present? && time.present? && name.present? && location.present? && link.present?
  end

  def to_s
    "#{date}, #{time}, #{name}, #{location}, #{link}"
  end
  
  def when
    zone = "Central Time (US & Canada)"
    result = ActiveSupport::TimeZone[zone].parse("#{date} #{time}")
  end

  def match?(other)
    date == other.date && name == other.name && location == other.location && time == other.time && link == other.link
  end

  def clean
    location.gsub!(/<[^>]*>/, '')
    location.squish!
    self
  end

  def to_event_model
    Event.new(name: self.name,
              location: self.location,
              time: self.when,
              link: self.link)
  end
end
