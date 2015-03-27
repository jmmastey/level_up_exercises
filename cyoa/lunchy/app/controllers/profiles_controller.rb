class ProfilesController < ApplicationController
  def update
    @user = current_user
    @profile = current_profile

    if @profile.update_attributes(profile_params)
      flash.now[:success] = "Settings updated successfully."
    end
    render 'users/show'
  end

  private

  def profile_params
    params.require(:profile).permit(:repeat_interval, :min_rating,
                                    :max_distance)
  end
end
