class LegislatorsController < ApplicationController
  before_action :set_legislator, only: [:show]

  def index
    @legislators = Legislator.all
  end

  def show
  end

  private
    def set_legislator
      @legislator = Legislator.find(params[:id])
    end
end
