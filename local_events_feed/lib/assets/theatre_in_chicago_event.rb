require 'date'
require 'active_support/all'

class TheatreInChicagoEvent
  attr_accessor :name, :location, :date, :time

  def initialize(date)
    @date = date
    @name = ''
    @location = ''
    @time = ''
  end

  def complete?
    date.present? && time.present? && name.present? && location.present?
  end

  def to_s
    "#{date}, #{time}, #{name}, #{location}"
  end

  def clean
    location.gsub!(/<[^>]*>/, '')
    location.gsub!(/\s+/, ' ')
    location.strip!
    self
  end
end
