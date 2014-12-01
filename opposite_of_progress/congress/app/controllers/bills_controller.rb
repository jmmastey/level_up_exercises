# Bills controller
class BillsController < ApplicationController
  before_action :set_bill, only: [:show]

  def index
    @results = Bill.all_sorted(params[:page], params[:sort_by])
  end

  def show
    @legislator = Legislator.where(bioguide_id: @bill.sponsor_id).first
  end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end
end
