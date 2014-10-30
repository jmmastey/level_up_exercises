class ArtistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

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
      message += "'#{name}' :("
      flash[:info] = message
    end
    redirect_to :back
  end

  def show
    unless @artist && @artist.nbs_id
      flash[:info] = "Whoops! We were unable to locate that artist you requested :("
      redirect_to artists_path
    end
  end

  private
    def set_artist
      # id = params[:id]
      # if id.is_a
      # @artist = Artist.find(params[:id])
      @artist = Artist.friendly.find(params[:id])
    end

    def artist_params
      params.require(:artist).permit(:slug)
    end
end