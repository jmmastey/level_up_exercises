class LegislatorsController < ApplicationController
  def index
    @legislators = Legislator.paginate(page: params[:page])
  end

  def show
    @legislator = Legislator.find(params[:id])
  end
end
