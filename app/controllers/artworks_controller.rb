class ArtworksController < ApplicationController
  def show
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.find(params[:id])
  end
end
