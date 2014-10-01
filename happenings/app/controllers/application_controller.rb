class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @events = Event.includes(:event_dates).all.limit(20)
    @venues = Venue.includes(:venue_events).all.limit(20)
  end
end
