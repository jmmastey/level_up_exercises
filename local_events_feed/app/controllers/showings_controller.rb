class ShowingsController < ApplicationController
  def show
    @showing = Showing.find(params[:id])
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
  end

  def add_to_user
    if signed_in?
      showing = Showing.find(params[:id])
      current_user.add_showing(showing)
    end
    redirect_to :back
  end

  def remove_from_user
    if signed_in?
      showing = Showing.find(params[:id])
      current_user.remove_showing(showing)
    end
    redirect_to :back
  end
end
