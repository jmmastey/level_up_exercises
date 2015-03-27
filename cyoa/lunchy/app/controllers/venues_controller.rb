class VenuesController < ApplicationController
  def index
    @venues = Venue.order(distance: :asc)
  end

  def recommend
    @user = current_user
    @profile = current_profile
    @rec = get_recommendation
    render 'users/show'
  end

  private

  def get_recommendation
    @venues ||= Venue.all
    @venues.select do |venue|
      venue.rating >= @profile.min_rating &&
      venue.distance <= @profile.max_distance
    end.sample
  end
end
