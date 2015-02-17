class GoodDeedsController < ApplicationController
  def index
    #@good_deeds = GoodDeed.joins(:legislator).order('legislators.firstname')
    #@good_deeds.group_by {  }
#    	paginate(page: params[:page])
	@good_deeds = GoodDeed.order(:legislator_id).paginate(page: params[:page])
  end

  def show
    @good_deed = GoodDeed.find(params[:id])
  end
end
