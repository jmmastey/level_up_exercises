# Deeds controller
class DeedsController < ApplicationController
  before_action :set_deed, only: [:show]

  def index
    @results = Deed.all_sorted(params[:page], "date DESC")
  end

  def show
    @legislator = Legislator.where(bioguide_id: @deed.bioguide_id).first
    @bill = Bill.where(bill_id: @deed.bill_id).first
    @related_deeds = Deed.all_related(@deed)
  end

  private

  def set_deed
    @deed = Deed.find(params[:id])
  end
end
