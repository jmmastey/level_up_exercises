class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @profile = init_profile
      render "users/show" 
    else
      render "home"
    end
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
