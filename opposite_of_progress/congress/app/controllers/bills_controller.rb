# Bills controller
class BillsController < ApplicationController
  before_action :set_bill, only: [:show]

  def index
    @results = Bill.all_sorted(params[:page], params[:sort_by])
  end

  def show
    @legislator = Legislator.by_bioguide_id(@bill.sponsor_id)
  end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end
end
