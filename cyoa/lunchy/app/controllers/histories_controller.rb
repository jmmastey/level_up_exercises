class HistoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :add]

  def index
    @history = History.where(user_id: session[:user_id]).order(visited: :desc)
    @venues = Venue.joins('INNER JOIN histories ON histories.venue_id = venues.venue_id')
    @entries = @history.zip(@venues)
  end

  def add
    venue = Venue.find_by(venue_id: params[:id])
    entry = History.new(user_id: session[:user_id], venue_id: venue.venue_id,
                        visited: Date.today)

    respond_to do |format|
      if entry.save 
        flash.now[:success] = "'#{venue.name}' has been added to your history."
        format.html { render 'users/show' }
        format.js { @success = true }
      else
        flash.now[:danger] = "Oops! Venue could not be added to your history."
        format.html { render 'users/show' }
        format.js { @success = false }
      end
    end
  end
end
