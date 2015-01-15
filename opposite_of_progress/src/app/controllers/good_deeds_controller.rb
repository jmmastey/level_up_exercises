class GoodDeedsController < ApplicationController
  before_action :set_good_deed, only: [:show]
  before_action :authenticate_user!, only: [:favorites]

  def index
    @good_deeds = GoodDeed.page(params[:page])
  end

  def show
  end

  def favorites
    legislator_ids = current_user.legislators.ids
    bills_ids = current_user.bills.ids
    # I could not find any better way to do where or condition
    # https://coderwall.com/p/dgv7ag/or-queries-with-arrays-as-arguments-in-rails-4
    query = GoodDeed.unscoped.where(bill_id: bills_ids, legislator_id: legislator_ids)
    @good_deeds = GoodDeed.where(query.where_values.inject(:or)).page(params[:page])
    render :index
  end

  private
    def set_good_deed
      @good_deed = GoodDeed.find(params[:id])
    end
end
