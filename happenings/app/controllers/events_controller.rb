class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update]
  include EventHelper

  def index
    session[:event_source] = events_params[:source] if events_params[:source].present?
    @events = Event.with_source(session[:event_source] || :theatre_in_chicago)
  end

  def show
    render_404 if @event.nil?
  end

  def new
    @event = Event.new
  end

  def create
    @event = CreateEvent.create(event_params)
    if @event && @event.errors.nil?
      flash[:notice] = "Created event!"
    else
      flash[:alert] = "Failed to create event!"
    end
    render :new
  end

  def edit
    render_404 if @event.nil?
  end

  def update
    if UpdateEvent.update(@event, event_params)
      flash[:notice] = "Updated event!"
    else
      flash[:alert] = "Failed to update event!"
    end
    render :edit
  end

  private

  def find_event
    @event = Event.where(id: params[:id]).first
  end
end
