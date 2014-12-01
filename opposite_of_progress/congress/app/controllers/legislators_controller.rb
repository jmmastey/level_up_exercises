# Legislators controller
class LegislatorsController < ApplicationController
  before_action :set_legislator, only: [:show]

  def index
    @results = Legislator.all_sorted(params[:page], params[:sort_by])
  end

  def show
    @related_bills = Bill.by_sponsor_id(@legislator.bioguide_id)
  end

  private

  def set_legislator
    @legislator = Legislator.find(params[:id])
  end
end
