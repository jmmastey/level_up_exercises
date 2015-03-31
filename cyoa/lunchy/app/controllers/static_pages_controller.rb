class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      init_session
      @profile = init_profile
      render "users/show"
    else
      render "home"
    end
  end

  private

  def init_session
    # These values are used to generate random venue recommendations
    session[:rng_seed] = rand(1...100)
    session[:rec_idx] = 0
  end

  # The first time a user logs in, no profile record will exist, so we
  # need to create one
  def init_profile
    return current_profile unless current_profile.nil?
    profile = Profile.new(user_id: @user.id)
    profile.save
    profile
  end
end
