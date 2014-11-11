class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  def add_user_showing
    user = User.find(params[:user_id])
    showing = Showing.find(params[:showing_id])
    @event = showing.event
    user.add_showing(showing)
    redirect_to @event
  end

  def remove_user_showing
    user = User.find(params[:user_id])
    showing = Showing.find(params[:showing_id])
    @event = showing.event
    user.remove_showing(showing)
    redirect_to @event
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :time)
  end
end
