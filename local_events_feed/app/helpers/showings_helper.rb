require 'theatre_in_chicago/event'

module ShowingsHelper

  def one_day_only?(showings)
    return false unless showings.present?
    sorted = showings.sorted
    sorted.first.time.to_date == sorted.last.time.to_date
  end

  def self.add_theatre_in_chicago(tic_event)
    event = find_model_event(tic_event)
    tic_event.showings.each do |time|
      event.showings.create(time: time)
    end
  end

  def member_label(showing)
    member?(showing) ? 'member' : 'non-member'
  end

  def member_label_for_event(event)
    member_in_event?(event) ? 'member' : 'non-member'
  end

  def member?(showing)
    showing.in?(current_user.showings)
  end

  def member_in_event?(event)
    current_user.has_showing_in?(event)
  end

  def pretty_date_range(showings)
    return '0 Showings' unless showings.present?
    first_view = ApplicationHelper::LocalTimeView.new(showings.first.time)
    last_view = ApplicationHelper::LocalTimeView.new(showings.last.time)
    return "#{first_view.pretty_date_no_dow} Only" if one_day_only?(showings)
    first_view.pretty_date_no_year + " - " + last_view.pretty_date_no_dow
  end

  def pretty_showing_count(showings)
    "#{showings.count} " + "Showing".pluralize(showings.count)
  end

  private

  def self.find_model_event(tic_event)
    ::Event.find_or_create_by(name: tic_event.name,
                              location: tic_event.location,
                              link: tic_event.link)
  end
end
