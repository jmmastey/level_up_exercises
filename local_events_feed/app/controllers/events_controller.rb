class EventsController < ApplicationController
  def index
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def remove_event
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.events.delete(@event)
    redirect_to events_path
  end

  def add_event
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.add_event(@event)
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :time)
  end
end
