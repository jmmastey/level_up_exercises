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
    name = params[:artist][:name]
    unless current_user.add_artist_name(name)
      message = "Whoops! We can't seem to find any data on the artist "
      message += "'#{name}'."
      flash[:info] = message
    end
    redirect_to :back
  end
end
