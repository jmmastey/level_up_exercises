class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update]

  def index
    @start_date = events_params[:start_date]
    @end_date = events_params[:end_date]
    @description = events_params[:description]
    @events = EventSearch.call(events_params)
  end

  def show
    render_404 and return if @event.nil?
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
    render_404 and return if @event.nil?
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
    params.permit(:event_source, :start_date, :end_date, :description)
  end

  def render_404
    render file: "#{Rails.root}/public/404",
           status: 404
  end

  def find_event
    @event = Event.where(id: params[:id]).first
  end
end
