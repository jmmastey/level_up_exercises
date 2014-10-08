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
      redirect_to events_path
    else
      render 'sign_up'
    end
  end

  def show
    if signed_in?
      redirect_to events_path
    else
      render plain: "Please Sign In First"
    end
  end

  def remove_event
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.events.delete(@event)
    @event.users.delete(@user)
    redirect_to events_path
  end

  def add_event
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.events << @event
    @event.users << @user
    redirect_to events
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
