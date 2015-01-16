class BillsController < ApplicationController
  before_action :set_bill, only: [:show]
  before_action :set_favorited_ids
  before_action :authenticate_user!, only: [:favorite]

  def index
    @bills = Bill.order(last_action_at: :desc).page(params[:page])
  end

  def show
  end

  def favorites
    @bills = current_user.bills.order(last_action_at: :desc).page(params[:page])
    render :index
  end

  private
  def set_bill
    @bill = Bill.includes([:actions, :sponsorships, :cosponsorships]).
      find(params[:id])
  end


  def set_favorited_ids
    return unless user_signed_in?
    @favorited_ids = current_user.bills.ids
  end
end
