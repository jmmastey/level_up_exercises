class BillsController < ApplicationController
  before_action :set_bill, only: [:show]

  def index
    @results = Bill.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end
end
