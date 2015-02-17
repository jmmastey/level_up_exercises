class UsersController < ApplicationController
  def edit
    @user = User.find(current_user.id)
  end
  
  def show
    redirect_to home_index_path
  end

  def update
    user = User.find(params[:id])
    
    redirect_to home_index_path
  end

  def user_params
    params.require(:user)
          .permit(user_notifications_attributes: [:notification_time,
                                                  :active])
  end
end
