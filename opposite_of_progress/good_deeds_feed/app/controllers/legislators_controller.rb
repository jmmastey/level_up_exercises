class LegislatorsController < ApplicationController
  def index
    @legislators = Legislator.paginate(page: params[:page])
  end

  def show
    @legislator = Legislator.find(params[:id])
    @good_deeds = @legislator.good_deeds.paginate(page: params[:page])
  end
end
