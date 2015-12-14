class Api::V1::BillsController < ApplicationController
  def index
    @bills = Bill.order("id ASC").paginate(
      page: params[:page] || 1,
      per_page: 10)
    render json: @bills
  end

  def show
    @bill = Bill.find(params[:id])
    render json: @bill
  end

  def update
    Bill.find(params[:id]).tap do |bill|
      bill.update_score(bill_update_params[:vote])
      @bill = bill
    end
    render json: @bill
  end

  private

  def bill_update_params
    params.require(:bill).permit(:vote)
  end
end
