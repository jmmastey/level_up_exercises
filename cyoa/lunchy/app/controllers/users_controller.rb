class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :logged_out_user, only: [:new]
  before_action :correct_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.order(name: :asc)
  end

  def show
    @profile = current_profile
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_url
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
 
  def correct_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @user = nil
    end
    redirect_to root_url unless current_user?(@user)
  end
end
