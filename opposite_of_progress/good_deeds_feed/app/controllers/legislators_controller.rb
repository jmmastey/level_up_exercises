class LegislatorsController < ApplicationController
  def index
  	@legislators = Legislator.all
  end

  def show
    @legislator = Legislator.find(params[:id])
  end

end
