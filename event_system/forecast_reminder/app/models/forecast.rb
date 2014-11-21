class Forecast < ActiveRecord::Base
  validates_uniqueness_of :time, scope: :zip_code

  def date_description
    if time.today?
      time.hour <= 12 ? "Today" : "Tonight"
    elsif time.to_date == Date.tomorrow
      time.hour <= 12 ? "Tomorrow" : "Tomorrow Night"
    else
      description = [Date::DAYNAMES[time.wday]]
      description << "Night" if time.hour > 12
      description.join(" ")
    end
  end

  def self.for_zip_code(zip_code, start_time = nil)
    start_time ||= Time.now.beginning_of_hour
    where(zip_code: zip_code).where(time: start_time..(start_time + 7.days))
      .order(:time).all
  end
end
