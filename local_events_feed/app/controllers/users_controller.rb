class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'index'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
