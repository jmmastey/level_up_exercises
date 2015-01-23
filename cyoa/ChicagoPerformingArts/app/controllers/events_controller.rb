# encoding: UTF-8
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    # @events = Event.all
    @events = Event.order('activity_start_date').paginate(page: params[:page], per_page: 25)
    @events = @events.where(cityname: params["city"]) if params["city"].present?
    @events = @events.where(sales_status: params["status"]) if params["status"].present?
    @start_date = params[:start_date].presence || Date.today.to_s
    @events = @events.where('activity_start_date >= ?', @start_date)
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
        format.html { redirect_to @event, notice: 'Event created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def event_params
    params.require(:event).permit(:placeName, :CityName, :activityStartDate, :activityEndDate)
  end
end
