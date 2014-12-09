class EventsController < ApplicationController
  def index
    @events = Event.all.sorted
  end

  def show
    @event = Event.find(params[:id])
  end
end
