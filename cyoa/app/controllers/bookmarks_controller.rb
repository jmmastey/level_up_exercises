class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_bill, only: [:create, :destroy]

  def create
    Bookmark.create(user_id: current_user.id, bill_id: @bill.id)
    redirect_to bill_path(@bill), notice: 'Bookmarked!'
  end

  def index
    @bills = current_user.bills.page(params[:page])
  end

  def destroy
    Bookmark.where(user_id: current_user.id, bill_id: @bill.id).first.destroy
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:bill_id)
  end

  def find_bill
    @bill = Bill.where(bookmark_params).first
  end
end
