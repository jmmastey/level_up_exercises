class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @artist = Artist.find(params[:artist_id])
    @artist.followers << current_user
    flash[:success] = "This artist is now a favorite of yours."
    redirect_to @artist
  end

  def destroy
    @artist = Artist.find(params[:artist_id])
    favorite = current_user.favorites.find_by(artist_id: params[:artist_id])
    favorite.destroy
    flash[:success] = "This artist is no longer a favorite of yours."
    redirect_to @artist
  end
end
