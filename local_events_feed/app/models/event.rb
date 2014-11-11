require 'icalendar'

class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :link, presence: true
  validate :must_be_a_unique_event

  has_many :showings, dependent: :destroy

  def Event.sort_by_name
    Event.all.sort { |a, b| a.name <=> b.name }
  end

  def add_showing(time: nil)
    return unless time.present?
    return if already_have_show_at?(time)
    create_showing(time)
  end

  def create_showing(time)
    showing = showings.build(time: time)
    showing.save if persisted?
    showing
  end

  def same_as?(other)
    name == other.name && location == other.location && link == other.link
  end

  def has_match_in?(list)
    list.any? { |other| other.same_as?(self) }
  end

  def pretty_date_range
    return 'No Showings' unless showings.present?
    return "#{pretty_date(showings.first.time)} Only" if Showing.one_day_only?(showings)
    pretty_date_no_year(showings.first.time) + " - " + pretty_date(showings.last.time)
  end

  def pretty_showing_count
    return 'No Showings' unless showings.present?
    return "#{showings.count} Showing" if showings.count == 1
    "#{showings.count} Showings"
  end

  def sorted_showings
    Showing.sort_by_time(showings)
  end

  def add_to_db
    if unique?
      save
    else
      add_showings_to_match
    end
  end

  private

  def add_showings_to_match
    matching_event = find_match
    return unless matching_event.present?
    showings.each { |showing| matching_event.add_showing(time: showing.time) }
  end

  def unique?
    !has_match_in?(other_events)
  end

  def other_events
    Event.all.reject { |e| e.id == self.id }
  end

  def find_match
    Event.find_by(name: name, location: location, link: link)
  end

  def already_have_show_at?(time)
    showings.all.any? { |showing| showing.time == time }
  end

  def must_be_a_unique_event
    return if unique?
    errors[:base] << "This is a duplicate event"
  end

  def pretty_date(time)
    time.strftime("%b %-d, %Y")
  end

  def pretty_date_no_year(time)
    time.strftime("%b %-d")
  end
end
