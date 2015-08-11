class BillsController < ApplicationController
  before_action :ensure_nonempty_query, only: :index

  def index
    @pg_results = PgSearch.multisearch(@search_params)
    @num_bills = @pg_results.count
    @pg_results = @pg_results.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render 'index', layout: false }
    end
  end

  def random_good_deed
    find_random_bill && return unless user_signed_in?

    tag_bills = current_user.tags.map(&:bills)
    legislator_bills = current_user.legislators_by_zipcode.map(&:bills)
    bill = (tag_bills + legislator_bills).flatten.sample
    redirect_to "/bills/#{bill.bill_id}"
  end

  def show
    @bill = Bill.find_by_bill_id(params[:bill_id])
    @legislator = @bill.legislator
    @bill_actions = @bill.bill_actions
    @important_actions = @bill_actions.important
    respond_to do |format|
      format.html
      format.json { render 'show', layout: false }
    end
  end

  private

  def find_random_bill
    redirect_to "/bills/#{Bill.all.sample.bill_id}"
  end
end
