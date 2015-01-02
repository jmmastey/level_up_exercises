class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_artist

  def create
    @artist.followers << current_user
    flash[:success] = "This artist is now a favorite of yours."
    redirect_to @artist
  end

  def destroy
    favorite = current_user.favorites.find_by(artist_id: params[:artist_id])
    favorite.destroy
    flash[:success] = "This artist is no longer a favorite of yours."
    redirect_to @artist
  end

  private

  def find_artist
    @artist = Artist.find(params[:artist_id])
  end
end
