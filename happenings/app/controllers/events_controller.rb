class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update]

  def index
    #@events = EventSearch.call(events_params)
    session[:event_source] = events_params[:event_source] if events_params[:event_source].present?
    @events = Event.with_source(session[:event_source] || :theatre_in_chicago)
  end

  def show
    render_404 if @event.nil?
    respond_to do |f|
      f.html
      f.ics   {render text: ICalEventPresenter.call([@event])}
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = CreateEvent.create(event_params)
    if @event.blank?
      flash.now[:alert] = "Failed to create event! Event already exists!"
    elsif @event.errors.present?
      flash.now[:alert] = "Failed to create event! errors: #{@event.errors.messages}"
    else
      flash.now[:notice] = "Created event!"
    end

    @event = Event.new
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

  def event_params
    params.require(:event).permit(:title, :time, :date, :description, :url, :source)
  end

  def events_params
    params.permit(:event_source, :start_date, :end_date)
  end

  def render_404
    render file: "#{Rails.root}/public/404",
           status: 404
  end

  def find_event
    @event = Event.where(id: params[:id]).first
  end
end
