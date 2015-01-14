class EventsController < ApplicationController
  before_action :login_filter

  def index
    @events = Event.all.sorted
  end

  def show
    @event = Event.find(params[:id])
  end
end
