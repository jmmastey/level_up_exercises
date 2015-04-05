class BlacklistsController < ApplicationController
  before_action :logged_in_user, only: [:add, :del]
  before_action :find_venue, only: [:add, :del]

  def add
    entry = Blacklist.new(user_id: session[:user_id], venue_id: @venue.id)

    respond_to do |format|
      if !exists?(@venue) && entry.save
        format.js { @success = true }
      else
        format.js { @success = false }
      end
    end
  end

  def del
    entry = Blacklist.find_by(user_id: session[:user_id],
                              venue_id: @venue.id)
    respond_to do |format|
      if entry && entry.destroy
        format.js { @success = true }
      else
        format.js { @success = false }
      end
    end
  end

  private

  def find_venue
    @venue = Venue.find_by(id: params[:id])
  end

  def exists?(venue)
    Blacklist.find_by(user_id: session[:user_id], venue_id: venue.id)
  end
end
