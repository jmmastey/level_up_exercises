class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    bill_id = bookmark_params[:bill_id]
    bill = Bill.find(bill_id)
    UserBill.create(user_id: current_user.id, bill_id: bill_id)
    redirect_to bill_path(bill_id: bill.bill_id), notice: 'Bookmarked!'
  end

  def index
    @bills = current_user.bills.page(params[:page])
  end

  def destroy
    bill_id = bookmark_params[:bill_id]
    UserBill.where(user_id: current_user.id, bill_id: bill_id).first.destroy
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.permit(:bill_id)
  end
end
