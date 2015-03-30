class ProfilesController < ApplicationController
  def update
    @user = current_user
    @profile = current_profile

    respond_to do |format|
      if @profile.update_attributes(profile_params)
        flash.now[:success] = "Settings updated successfully."
        format.html { render 'users/show' }
        format.js { @success = true }
      else
        flash.now[:danger] = "Oops! Settings could not be saved."
        format.html { render 'users/show' }
        format.js { @success = false }
      end
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:repeat_interval, :min_rating,
                                    :max_distance)
  end
end
