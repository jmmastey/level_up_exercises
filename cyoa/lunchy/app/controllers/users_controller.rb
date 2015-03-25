class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :logged_out_user, only: [:new]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Lunchy!"
      log_in @user
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "You must be logged in to view this page."
      redirect_to login_url
    end
  end

  def logged_out_user
    if logged_in?
      redirect_to root_url
    end
  end
 
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
end
