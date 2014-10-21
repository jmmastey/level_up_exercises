class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]

  # GET /events
  # GET /events.json
  def index
    @events = Event.includes(:event_dates, :venue).all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html do
          redirect_to @event,
            notice: 'Event was successfully created.'
        end
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json do
          render json: @event.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html do
          redirect_to @event,
            notice: 'Event was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json do
          render json: @event.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html do
        redirect_to events_url,
          notice: 'Event was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.includes(:event_dates, :venue).find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :venue_id, :description,
      :price, :show_type, :phone_number,
      :running_time, :event_url)
  end
end
