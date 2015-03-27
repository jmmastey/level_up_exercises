class ProfilesController < ApplicationController
  def update
    @user = current_user
    @profile = current_profile
    redirect_to root_url
  end
end
