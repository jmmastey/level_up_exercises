class EventSourcesController < ApplicationController
  before_action :set_event_source, only: [:show, :edit, :update, :destroy]

  respond_to :html

  PERMITTED_PARAMS = [:name, :source_type, :uri, :frequency, :last_harvest]

  def index
    @event_sources = EventSource.all
    respond_with(@event_sources)
  end

  def show
    respond_with(@event_source)
  end

  def new
    @event_source = EventSource.new
    respond_with(@event_source)
  end

  def edit
  end

  def create
    @event_source = EventSource.new(event_source_params)
    @event_source.save
    respond_with(@event_source)
  end

  def update
    @event_source.update(event_source_params)
    respond_with(@event_source)
  end

  def destroy
    @event_source.destroy
    respond_with(@event_source)
  end

  private

  def set_event_source
    @event_source = EventSource.find(params[:id])
  end

  def event_source_params
    params.require(:event_source).permit(PERMITTED_PARAMS)
  end
end
