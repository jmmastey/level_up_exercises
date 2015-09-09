class CharacterZoneActivitiesController < ApplicationController
  before_action :set_character_zone_activity, only: [:show, :edit, :update, :destroy]

  # GET /character_zone_activities
  # GET /character_zone_activities.json
  def index
    @character_zone_activities = CharacterZoneActivity.all
  end

  # GET /character_zone_activities/1
  # GET /character_zone_activities/1.json
  def show
  end

  # GET /character_zone_activities/new
  def new
    @character_zone_activity = CharacterZoneActivity.new
  end

  # GET /character_zone_activities/1/edit
  def edit
  end

  # POST /character_zone_activities
  # POST /character_zone_activities.json
  def create
    @character_zone_activity = CharacterZoneActivity.new(character_zone_activity_params)

    respond_to do |format|
      if @character_zone_activity.save
        format.html { redirect_to @character_zone_activity, notice: 'Character zone activity was successfully created.' }
        format.json { render :show, status: :created, location: @character_zone_activity }
      else
        format.html { render :new }
        format.json { render json: @character_zone_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /character_zone_activities/1
  # PATCH/PUT /character_zone_activities/1.json
  def update
    respond_to do |format|
      if @character_zone_activity.update(character_zone_activity_params)
        format.html { redirect_to @character_zone_activity, notice: 'Character zone activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @character_zone_activity }
      else
        format.html { render :edit }
        format.json { render json: @character_zone_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character_zone_activities/1
  # DELETE /character_zone_activities/1.json
  def destroy
    @character_zone_activity.destroy
    respond_to do |format|
      format.html { redirect_to character_zone_activities_url, notice: 'Character zone activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character_zone_activity
      @character_zone_activity = CharacterZoneActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_zone_activity_params
      params[:character_zone_activity]
    end
end
