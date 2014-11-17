class DeedsController < ApplicationController
  before_action :set_deed, only: [:show, :update, :destroy]

  def index
    @results = Deed.order(date: :desc, deed: :asc).paginate(:page => params[:page], :per_page => ApplicationHelper::PAGINATION_COUNT)
  end

  def show
    @related_deeds = Deed.where('id != ? and (bioguide_id = ? or bill_id = ?)', @deed.id, @deed.bioguide_id, @deed.bill_id)
  end

  private
    def set_deed
      @deed = Deed.find(params[:id])
    end
end
