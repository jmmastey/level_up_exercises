class EventSearch < ActiveRecord::Base
  attr_reader :start_date

  def initialize(params)
    params ||= {}
    @start_date = parsed_date(params[:activity_start_date], Date.today.to_s)
  end

  def scope
    Event.where('activity_start_date >= ?', @start_date)
  end

  private

  def parsed_date(date_string, default)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    default
  end
end
