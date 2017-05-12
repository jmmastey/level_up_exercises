class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.includes(:events).all
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html do
          redirect_to @venue,
            notice: 'Venue was successfully created.'
        end
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json do
          render json:   @venue.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html do
          redirect_to @venue,
            notice: 'Venue was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json do
          render json:   @venue.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html do
        redirect_to venues_url,
          notice: 'Venue was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.includes(:events).find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def venue_params
    params.require(:venue).permit(:name, :address, :city, :zipcode,
      :description, :phone_number, :venue_url)
  end
end
