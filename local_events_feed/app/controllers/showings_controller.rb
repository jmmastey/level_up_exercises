class ShowingsController < ApplicationController
  def show
    # respond-to ics
  end

  def add_showing_to_calendar
    @showing = Showing.find(params[:showing_id])
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
  end

  def add_to_user
    if signed_in?
      showing = Showing.find(params[:showing_id])
      current_user.add_showing(showing)
    end
    redirect_to :back
  end

  def remove_from_user
    if signed_in?
      showing = Showing.find(params[:showing_id])
      current_user.remove_showing(showing)
    end
    redirect_to :back
  end
end
