class GoodDeedsController < ApplicationController
  before_action :set_good_deed, only: [:show]

  def index
    @good_deeds = GoodDeed.page(params[:page])
  end

  def show
  end

  private
    def set_good_deed
      @good_deed = GoodDeed.find(params[:id])
    end
end
