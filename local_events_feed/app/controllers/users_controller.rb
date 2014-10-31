class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  def remove_showing
    user = User.find(params[:id])
    showing = Showing.find(params[:showing_id])
    user.remove_showing(showing)
    redirect_to request.referer
  end

  def add_showing_to_calendar
    @showing = Showing.find(params[:showing_id])
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def failed_to_authenticate?(params)
    user = User.find_by(email: params[:email])
    return true unless user.present?
    return true if user.authenticate(params[:password]) != user
    false
  end
end
