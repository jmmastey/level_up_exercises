class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:update]
  before_action :correct_profile, only: [:update]

  def update
    @user = current_user
    @profile = current_profile

    respond_to do |format|
      if @profile.update_attributes(profile_params)
        flash.now[:success] = "Settings updated successfully."
        # This index must be reset here since changing the profile settings
        # can change the length of the list of recommended venues
        session[:rec_idx] = 0
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

  def correct_profile
    begin
      @profile = Profile.find(params[:id])
      @user = User.find(@profile.user_id)
    rescue ActiveRecord::RecordNotFound
      @profile = nil
      @user = nil
    end
    redirect_to root_url unless current_user?(@user)
  end
end
