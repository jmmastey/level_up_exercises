class ArtworksController < ApplicationController

  def index
    @artist = Artist.find(params[:artist_id])
    @artworks = @artist.artworks.all
  end

  def show
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.find(params[:id])
  end
end
