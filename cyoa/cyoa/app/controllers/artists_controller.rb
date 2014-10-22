class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @artists = current_user.artists
    @artist = Artist.new
  end

  def destroy
    artist = Artist.find(params[:id])
    current_user.remove_artist(artist)
    redirect_to :back
  end

  def create
    artist = Artist.find_or_create_by_unique_name(params[:artist][:name])
    current_user.artists << artist
    redirect_to :back
  end
end
