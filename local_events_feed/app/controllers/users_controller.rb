class UsersController < ApplicationController
  def index
  end

  def create
    @user = get_user(user_params)

    if @user.save
      redirect_to @user
    else
      render 'index'
    end
  end

  def show
    @user = User.find(params[:id])
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
    params.require(:user).permit(:name)
  end

  def get_user(params)
    name = params[:name]
    find_user(name) || User.create(params)
  end

  def find_user(name)
    User.all.detect { |user| user[:name] == name }
  end

end
