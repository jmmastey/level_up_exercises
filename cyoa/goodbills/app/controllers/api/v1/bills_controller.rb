class Api::V1::BillsController < ApplicationController
  def index
    @bills = Bill.order("id ASC").first(10)
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def update
    Bill.find(params[:id]).tap { |bill|
      bill.update_score(bill_update_params[:vote])
      @bill = bill
    }
  end

  private
  def bill_update_params
    params.require(:bill).permit(:vote)
  end
end
