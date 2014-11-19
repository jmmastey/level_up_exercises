class BillsController < ApplicationController
  before_action :set_bill, only: [:show]

  def index
    @results = Bill.order(created_at: :desc).paginate(:page => params[:page], :per_page => ApplicationHelper::PAGINATION_COUNT)
  end

  def show
    @legislator = Legislator.where(bioguide_id: @bill.sponsor_id).first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end
end
