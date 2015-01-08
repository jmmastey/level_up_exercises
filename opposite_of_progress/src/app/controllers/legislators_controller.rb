class LegislatorsController < ApplicationController
  before_action :set_legislator, only: [:show]

  def index
    @legislators = Legislator.order(chamber: :desc, last_name: :asc)
      .page(params[:page])
  end

  def show
  end

  private

  def set_legislator
    @legislator = Legislator.find(params[:id])
  end
end
