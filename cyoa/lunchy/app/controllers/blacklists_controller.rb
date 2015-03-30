class BlacklistsController < ApplicationController
  before_action :logged_in_user, only: [:add, :del]

  def add
    venue = Venue.find_by(id: params[:id])
    exists = Blacklist.find_by(user_id: session[:user_id], venue_id: venue.id)
    entry = Blacklist.new(user_id: session[:user_id], venue_id: venue.id)

    respond_to do |format|
      if !exists && entry.save 
        format.js { @success = true }
      else
        format.js { @success = false }
      end
    end
  end

  def del
    venue = Venue.find_by(id: params[:id])
    entry = Blacklist.find_by(user_id: session[:user_id], venue_id: venue.id)
    respond_to do |format|
      if entry && entry.destroy
        format.js { @success = true }
      else
        format.js { @success = false }
      end
    end
  end
end
