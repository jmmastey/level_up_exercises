class DeedsController < ApplicationController
  before_action :set_deed, only: [:show, :update, :destroy]

  def index
    @results = Deed.order(date: :desc, deed: :asc).all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deed
      @deed = Deed.find(params[:id])
    end
end
