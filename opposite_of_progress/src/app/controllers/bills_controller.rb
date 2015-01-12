class BillsController < ApplicationController
  before_action :set_bill, only: [:show]

  def index
    @bills = Bill.page(params[:page])
  end

  def show
  end

  private
    def set_bill
      @bill = Bill.find(params[:id])
    end
end
