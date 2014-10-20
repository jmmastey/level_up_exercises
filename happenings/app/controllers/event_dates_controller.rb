class EventDatesController < ApplicationController
  before_action :set_event_date, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]


  # GET /event_dates
  # GET /event_dates.json
  def index
    @event_dates = EventDate.all
  end

  # GET /event_dates/1
  # GET /event_dates/1.json
  def show
  end

  # GET /event_dates/new
  def new
    @event_date = EventDate.new
  end

  # GET /event_dates/1/edit
  def edit
  end

  # POST /event_dates
  # POST /event_dates.json
  def create
    @event_date = EventDate.new(event_date_params)

    respond_to do |format|
      if @event_date.save
        format.html do
          redirect_to @event_date,
            notice: 'Event date was successfully created.'
        end
        format.json { render :show, status: :created, location: @event_date }
      else
        format.html { render :new }
        format.json do
          render json:   @event_date.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /event_dates/1
  # PATCH/PUT /event_dates/1.json
  def update
    respond_to do |format|
      if @event_date.update(event_date_params)
        format.html do
          redirect_to @event_date,
            notice: 'Event date was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @event_date
        end
      else
        format.html { render :edit }
        format.json do
          render json:   @event_date.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /event_dates/1
  # DELETE /event_dates/1.json
  def destroy
    @event_date.destroy
    respond_to do |format|
      format.html do
        redirect_to event_dates_url,
          notice: 'Event date was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event_date
    @event_date = EventDate.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def event_date_params
    params.require(:event_date).permit(:venue_id, :date_time, :event_id)
  end
end
