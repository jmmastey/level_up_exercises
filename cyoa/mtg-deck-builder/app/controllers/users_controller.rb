class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @decks = @user.decks.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Awesome! Your profile has been updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Woohoo! Welcome to MTG Deck builder!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    flash[:success] = "Your account has been destroyed."
    current_user.destroy
    redirect_to "/"
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation)
  end

  def logged_in_user
    return unless logged_in?
    flash[:error] = "Oops! You need to log in."
    redirect_to login_url
  end
end
