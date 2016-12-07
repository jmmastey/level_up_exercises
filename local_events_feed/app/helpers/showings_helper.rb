require 'theatre_in_chicago/event'

module ShowingsHelper
  def self.one_day_only?(showings)
    return false unless showings.present?
    sorted = showings.sorted
    sorted.first.time.to_date == sorted.last.time.to_date
  end

  def self.pretty_date_range(showings)
    return 'No Showings' unless showings.present?
    first_view = ApplicationHelper::LocalTimeView.new(showings.first.time)
    last_view = ApplicationHelper::LocalTimeView.new(showings.last.time)
    return "#{first_view.pretty_date_no_dow} Only" if one_day_only?(showings)
    first_view.pretty_date_no_year + " - " + last_view.pretty_date_no_dow
  end

  def self.pretty_showing_count(showings)
    return 'No Showings' unless showings.present?
    return "#{showings.count} Showing" if showings.count == 1
    "#{showings.count} Showings"
  end

  def self.add_theatre_in_chicago(tic_event)
    event = find_model_event(tic_event)
    tic_event.showings.each do |time|
      event.showings.create(time: time)
    end
  end

  private

  def self.find_model_event(tic_event)
    ::Event.find_or_create_by(name: tic_event.name,
                              location: tic_event.location,
                              link: tic_event.link)
  end
end
