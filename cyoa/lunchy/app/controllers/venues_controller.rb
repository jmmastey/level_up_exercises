class VenuesController < ApplicationController
  def index
    @venues = Venue.order(distance: :asc)
  end

  # Provides randomized recommendations according to user search criteria
  # Since we don't want repeats, we will do the following:
  # - On initial user page load, generate a random seed and set rec_idx = 0.
  #   Store both of these variables in the session.
  # - When recommend is called, generate a list of possible venues and
  #   scramble it using the stored random seed.
  # - Return the item stored at rec_idx.
  # - Increment rec_idx and store it in the session.
  #
  # The session variables are initialized in the static_pages controller.
  def recommend
    @user = current_user
    @profile = current_profile
    @rec = next_recommendation

    session[:rec_idx] = (session[:rec_idx] + 1) % @length

    respond_to do |format|
      format.html { render 'users/show' }
      format.js { @history_add_url = "/history/add/#{@rec.venue_id}" }
    end
  end

  private

  def next_recommendation
    venues = load_filtered_venues
    @length = venues.length
    venues.shuffle!(random: Random.new(session[:rng_seed]))
    venues[session[:rec_idx]]
  end

  def load_filtered_venues
    venues ||= Venue.order(distance: :asc)
    venues.select { |v| rating_ok?(v) && distance_ok?(v) && !repeat?(v) }
  end

  def rating_ok?(venue) 
    venue.rating >= @profile.min_rating
  end

  def distance_ok?(venue) 
    venue.distance <= @profile.max_distance
  end

  def repeat?(venue)
    return false if @profile.repeat_interval == 1

    @entries = History.where(user_id: session[:user_id])
    @entries.index do |entry|
      entry.venue_id == venue.id &&
      (Date.today - entry.visited) < @profile.repeat_interval
    end
  end
end
