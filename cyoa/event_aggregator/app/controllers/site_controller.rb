class SiteController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @highlight_events = highlight_events
    @meetups = meetups
    @opening_night_events = opening_night_events
  end

  private

  def highlight_events
    random_events(4)
  end

  def meetups
    random_events(2)
  end

  def opening_night_events
    random_events(2)
  end

  def random_events(count)
    CalendarEvent.select(:family_hash).distinct.sample(count).map do |event|
      CalendarEvent.find_by(family_hash: event[:family_hash])
    end
  end
end
