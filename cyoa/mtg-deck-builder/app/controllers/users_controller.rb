class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'create'
    else
      render 'new'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation)
  end
end
