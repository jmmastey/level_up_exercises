class ArtworksController < ApplicationController

  def index
    @artist = Artist.find(params[:artist_id])
    @artworks = @artist.artworks.all
  end

  def show
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.find(params[:id])
  end

  def new
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.new
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.new(artwork_params)
    if @artwork.save
      flash[:notice] = "The artwork was successfully created."
      redirect_to artist_artwork_url(@artist, @artwork)
    else
      flash[:notice] = "The artwork could not be saved."
      render 'new'
    end
  end

  def edit
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.find(params[:id])
    if @artwork.update(artwork_params)
      flash[:notice] = "The artwork was successfully updated."
      redirect_to artist_artwork_url(@artist, @artwork)
    else
      render 'edit'
    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :date, :thumbnail)
  end
end
