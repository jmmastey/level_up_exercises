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
    "#{date}, #{time}, #{name}, #{location}, #link"
  end
  
  def when
    DateTime.parse("#{date}T#{time}+0600")
  end

  def match?(other)
    date == other.date && name == other.name && location == other.location && time == other.time && link == other.link
  end

  def clean
    location.gsub!(/<[^>]*>/, '')
    location.gsub!(/\s+/, ' ')
    location.strip!
    self
  end
end
