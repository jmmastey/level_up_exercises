class ArtworksController < ApplicationController
  before_action :find_artist
  before_action :find_artwork, only: [:show, :edit, :update, :destroy]

  def index
    @artworks = @artist.artworks.all
  end

  def show
  end

  def new
    @artwork = @artist.artworks.new
  end

  def create
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
  end

  def update
    if @artwork.update(artwork_params)
      flash[:success] = "The artwork was successfully updated."
      redirect_to artist_artwork_url(@artist, @artwork)
    else
      render 'edit'
    end
  end

  def destroy
    @artwork.destroy
    flash[:success] = "The artwork was successfully deleted."
    redirect_to artist_artworks_url(@artist)
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :date, :thumbnail)
  end

  def find_artist
    @artist = Artist.find(params[:artist_id])
  end

  def find_artwork
    @artwork = @artist.artworks.find(params[:id])
  end
end
