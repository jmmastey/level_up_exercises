class BillsController < ApplicationController
  before_action :set_bill, only: [:show]

  def index
    @bills = Bill.order(last_action_at: :desc).page(params[:page])
  end

  def show
  end

  private
    def set_bill
      @bill = Bill.includes([:actions, :sponsorships, :cosponsorships]).
        find(params[:id])
    end
end
