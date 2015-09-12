class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.all
    if specific_character_requested?
      go_to_character
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    Character.refresh_individual(name: @character.name, realm: @character.realm)
    @zone_summaries = @character.zone_summaries
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
  end

  
  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character,
                      notice: 'Character was successfully created.' }
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character,
                      notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html do
        redirect_to characters_url,
                    notice: 'Character was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :realm)
    end

    def specific_character_requested?
      name = params['Name']
      return true if name && !name.empty?
      realm = params['Realm']
      realm && !realm.empty?
    end

    def go_to_character
      @character = Character.refresh_individual(name: params['Name'].titleize,
                                                realm: params['Realm'])
      if !@character.nil? && @character.name.eql?(params['Name'].titleize)
        flash.delete :notice
        redirect_to @character
      else
        flash[:notice] = "Character does not exist"
      end
    end
end
