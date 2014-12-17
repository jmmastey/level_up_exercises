class EventsController < ApplicationController
  include EventHelper
  def index
    permitted_params = filter_params(params)
    session[:event_source] = permitted_params[:source] if permitted_params[:source].present?
    @events = Event.with_source(session[:event_source] || :theatre_in_chicago)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
  end

  def edit
  end

  def update
  end
end
