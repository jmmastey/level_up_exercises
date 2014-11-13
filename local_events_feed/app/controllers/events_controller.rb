class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
  end
end
