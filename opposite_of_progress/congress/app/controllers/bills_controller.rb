class BillsController < ApplicationController
  before_action :set_bill, only: [:show]

  def index
    @results = Bill.all
    # @results = Deed.new.law_voted_on
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end
end
