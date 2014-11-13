class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :time)
  end
end
