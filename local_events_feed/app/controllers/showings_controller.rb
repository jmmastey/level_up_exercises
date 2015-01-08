class ShowingsController < ApplicationController
  before_action :login_filter
  before_action :get_showing

  def show
    respond_to do |format|
      format.ical { render :text => @showing.to_ics }
    end
  end

  def add
    current_user.add_showing(@showing)
    redirect_to :back
  end

  def destroy
    current_user.showings.delete(@showing)
    redirect_to :back
  end

  private

  def get_showing
    @showing = Showing.find(params[:id])
  end
end
