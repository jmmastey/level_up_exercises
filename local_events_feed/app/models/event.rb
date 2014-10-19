require 'icalendar'

class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :link, presence: true
  validate :must_be_a_unique_event

  has_many :showings, dependent: :destroy

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
    pretty_date(showings.first.time) + " - " + pretty_date(showings.last.time)
  end

  def sorted_showings
    Showing.sort_by_time(showings)
  end

  private

  def unique?
    !has_match_in?(Event.all)
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
end
