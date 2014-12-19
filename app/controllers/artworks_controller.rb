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
      flash[:success] = "The artwork was successfully created."
      redirect_to artist_artwork_url(@artist, @artwork)
    else
      flash[:success] = "The artwork could not be saved."
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
      flash[:success] = "The artwork was successfully updated."
      redirect_to artist_artwork_url(@artist, @artwork)
    else
      render 'edit'
    end
  end

  def destroy
    @artist = Artist.find(params[:artist_id])
    @artwork = @artist.artworks.find(params[:id])
    @artwork.destroy
    flash[:success] = "The artwork was successfully deleted."
    redirect_to artist_artworks_url(@artist)
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :date, :thumbnail)
  end
end
