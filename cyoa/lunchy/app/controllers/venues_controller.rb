class VenuesController < ApplicationController
  before_action :logged_in_user, only: [:index, :recommend]

  include VenuesHelper

  def index
    @blacklist = Blacklist.where(user_id: session[:user_id])
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

    respond_to do |format|
      if @rec.nil?
        format.html { render 'users/show' }
        format.js {}
      else
        format.html { render 'users/show' }
        format.js { @history_add_url = "/history/add/#{@rec.venue_id}" }
      end
    end
  end

  private

  def next_recommendation
    venues = load_filtered_venues
    venues.shuffle!(random: Random.new(session[:rng_seed]))
    curr_idx = session[:rec_idx]
    length = venues.length
    session[:rec_idx] = (curr_idx + 1) % length if length > 0
    venues[curr_idx]
  end

  def load_filtered_venues
    @blacklist = Blacklist.where(user_id: session[:user_id])
    venues ||= Venue.order(distance: :asc)
    venues.select do |v|
      rating_ok?(v) && distance_ok?(v) && !repeat?(v) & !blacklisted?(v)
    end
  end

  def rating_ok?(venue)
    venue.rating >= @profile.min_rating
  end

  def distance_ok?(venue)
    venue.distance <= @profile.max_distance
  end

  def repeat?(venue)
    @entries ||= History.where(user_id: session[:user_id])
    @entries.index { |item| item.venue_id == venue.id && too_soon?(item) }
  end

  def too_soon?(item)
    (Date.today - item.visited) < @profile.repeat_interval
  end
end
