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
      render 'sign_up'
    end
  end

  def show
    please_sign_in if !signed_in?
    @user = current_user
  end

  def please_sign_in
    render plain: "Please sign in first"
  end

  def remove_event
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.events.delete(@event)
    redirect_to @user
  end

  def add_event
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.add_event(@event)
    redirect_to events_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def failed_to_authenticate?(params)
    @user = User.find_by(email: params[:email])
    return true if @user.nil?
    return true if @user.authenticate(params[:password]) != @user
    false
  end
end
