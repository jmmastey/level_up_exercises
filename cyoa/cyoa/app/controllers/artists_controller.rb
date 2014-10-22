class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @artists = current_user.nbs_artists
    @artist = Artist.new
  end

  def destroy
    artist = Artist.find(params[:id])
    current_user.remove_artist(artist)
    redirect_to :back
  end

  def create
    current_user.add_artist_name(params[:artist][:name])
    redirect_to :back
  end
end
