class FavoritesController < ApplicationController

  def create
    @artist = Artist.find(params[:artist_id])
    @artist.followers << current_user
    flash[:notice] = "This artist is now a favorite of yours."
    redirect_to @artist
  end
end
