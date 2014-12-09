class ShowingsController < ApplicationController
  before_action :login_filter
  before_action :get_showing

  def show
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
  end

  def add_to_user
    current_user.add_showing(@showing)
    redirect_to :back
  end

  def remove_from_user
    current_user.showings.delete(@showing)
    redirect_to :back
  end

  private

  def get_showing
    @showing = Showing.find(params[:id])
  end

  def login_filter
    redirect_to :back unless signed_in?
  end
end
