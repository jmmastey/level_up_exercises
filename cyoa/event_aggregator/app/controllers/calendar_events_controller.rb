class CalendarEventsController < ApplicationController
  before_action :set_calendar_event, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @calendar_events = CalendarEvent.all
    respond_with(@calendar_events)
  end

  def show
    respond_with(@calendar_event)
  end

  def new
    @calendar_event = CalendarEvent.new
    respond_with(@calendar_event)
  end

  def edit
  end

  def create
    @calendar_event = CalendarEvent.new(calendar_event_params)
    @calendar_event.save
    respond_with(@calendar_event)
  end

  def update
    @calendar_event.update(calendar_event_params)
    respond_with(@calendar_event)
  end

  def destroy
    @calendar_event.destroy
    respond_with(@calendar_event)
  end

  private
    def set_calendar_event
      @calendar_event = CalendarEvent.find(params[:id])
    end

    def calendar_event_params
      params.require(:calendar_event).permit(:title, :start_time, :end_time, :description, :event_hash, :family_hash, :location, :host)
    end
end
