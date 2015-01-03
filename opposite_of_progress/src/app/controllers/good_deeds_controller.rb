class GoodDeedsController < ApplicationController
  before_action :set_good_deed, only: [:show, :edit, :update, :destroy]

  # GET /good_deeds
  # GET /good_deeds.json
  def index
    @good_deeds = GoodDeed.all
  end

  # GET /good_deeds/1
  # GET /good_deeds/1.json
  def show
  end

  # GET /good_deeds/new
  def new
    @good_deed = GoodDeed.new
  end

  # GET /good_deeds/1/edit
  def edit
  end

  # POST /good_deeds
  # POST /good_deeds.json
  def create
    @good_deed = GoodDeed.new(good_deed_params)

    respond_to do |format|
      if @good_deed.save
        format.html { redirect_to @good_deed, notice: 'Good deed was successfully created.' }
        format.json { render :show, status: :created, location: @good_deed }
      else
        format.html { render :new }
        format.json { render json: @good_deed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /good_deeds/1
  # PATCH/PUT /good_deeds/1.json
  def update
    respond_to do |format|
      if @good_deed.update(good_deed_params)
        format.html { redirect_to @good_deed, notice: 'Good deed was successfully updated.' }
        format.json { render :show, status: :ok, location: @good_deed }
      else
        format.html { render :edit }
        format.json { render json: @good_deed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /good_deeds/1
  # DELETE /good_deeds/1.json
  def destroy
    @good_deed.destroy
    respond_to do |format|
      format.html { redirect_to good_deeds_url, notice: 'Good deed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good_deed
      @good_deed = GoodDeed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_deed_params
      params[:good_deed]
    end
end
