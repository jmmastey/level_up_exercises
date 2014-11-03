class LegislatorsController < ApplicationController
  before_action :set_legislator, only: [:show, :update, :destroy]

  def index
    @results = Legislator.order(:bioguide_id).paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def update
    respond_to do |format|
      if @legislator.update(legislator_params)
        format.html { redirect_to @legislator, notice: 'Legislator was successfully updated.' }
        format.json { render :show, status: :ok, location: @legislator }
      else
        format.html { render :edit }
        format.json { render json: @legislator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @legislator.destroy
    respond_to do |format|
      format.html { redirect_to legislator_url, notice: 'Legislator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_legislator
      @legislator = Legislator.find(params[:id])
    end
end
