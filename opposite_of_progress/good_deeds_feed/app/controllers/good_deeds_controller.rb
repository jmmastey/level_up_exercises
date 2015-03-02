class GoodDeedsController < ApplicationController
  def index
    @good_deeds = GoodDeed.order(:legislator_id).paginate(page: params[:page])
  end

  def show
    @good_deed = GoodDeed.find(params[:id])
  end

  def by_party
    @good_deeds = GoodDeed.by_party(params[:party]).
                    paginate(page: params[:page])
    render :index
  end

  def json_feed
    @json_deeds = GoodDeed.to_json
    render json: @json_deeds
  end
end
