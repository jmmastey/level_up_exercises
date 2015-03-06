class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    unless current_user.following_legislator?(Legislator.find(params[:id]))
      legislator = Legislator.find(params[:id])
      current_user.favorite_legislator(legislator)
    end
    redirect_to user_url(current_user)
  end

  def destroy
    if current_user.favorites.exists?(id: params[:id])
      current_user.favorites.find(params[:id]).destroy
      flash[:success] = "Favorite removed"
    end
    redirect_to user_url(current_user)
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger].now = "Please log in."
      redirect_to login_url
    end
  end
end
