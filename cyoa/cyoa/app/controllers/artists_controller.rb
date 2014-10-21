class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @artists = current_user.artists
  end

  def destroy
    artist = Artist.find(params[:id])
    current_user.remove_artist(artist)
    redirect_to :back
  end
end
