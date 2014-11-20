class LegislatorsController < ApplicationController
  before_action :set_legislator, only: [:show]

  def index(sort_by = "created_at DESC")
    sort_by = params["sort_by"] if params["sort_by"]
    @results = Legislator.order(sort_by).paginate(:page => params[:page], :per_page => ApplicationHelper::PAGINATION_COUNT)
  end

  def show
    @related_bills = Bill.where(sponsor_id: @legislator.bioguide_id)
  end

  private
    def set_legislator
      @legislator = Legislator.find(params[:id])
    end
end
