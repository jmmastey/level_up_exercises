class EventsController < ApplicationController
  include EventHelper
  def index
    session[:event_source] = events_params[:source] if events_params[:source].present?
    @events = Event.with_source(session[:event_source] || :theatre_in_chicago)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = CreateEvent.create(event_params)
    if @event
      flash[:notice] = "Created event!"
    else
      flash[:alert] = "Failed to create event!"
    end
    render :new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = UpdateEvent.update(event_params)
    if @event
      flash[:notice] = "Updated event!"
    else
      flash[:alert] = "Failed to update event!"
    end
    render :edit, @event
  end
end
