class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :retrieve_users, only: [:index]
  before_action :retrieve_current_user, only: [:edit, :update]

  def update
    if @user.update(profile_params)
      flash[:notice] = "Profile updated."
      redirect_to :show
    else
      render :edit
    end
  end

  def show
    if params[:id] && params[:id] != current_user.id
      @user = User.visible.find(params[:id])
    else
      @user = current_user
    end
  end

  private

  def retrieve_current_user
    @user = current_user
  end

  def retrieve_users
    @users = User.visible.order(:last_name, :first_name)
  end

  def profile_params
    params.require(:user).permit(:last_name, :first_name, :phone, :city, :state,
                                 :zip, :about, :profile_visible,
                                 :contact_visible)
  end
end
