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
    if @event.blank?
      flash.now[:alert] = "Failed to create event! Event already exists!"
      @event = Event.new
    elsif @event.errors.present?
      flash.now[:alert] = "Failed to create event! errors: #{@event.errors.messages}"
      @event = Event.new
    else
      flash.now[:notice] = "Created event!"
    end

    render :new
  end

  def edit
    render_404 if @event.nil?
  end

  def update
    if UpdateEvent.update(@event, event_params)
      flash.now[:notice] = "Updated event!"
    else
      flash.now[:alert] = "Failed to update event!"
    end
    render :edit
  end

  private

  def find_event
    @event = Event.where(id: params[:id]).first
  end
end
