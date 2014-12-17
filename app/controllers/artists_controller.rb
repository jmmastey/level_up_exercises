class ArtistsController < ApplicationController
  before_action :find_artist, only: [:show, :edit, :update, :destroy]

  def index
    @artists = Artist.all
  end

  def show
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:success] = "The artist was successfully created."
      redirect_to artist_url(@artist)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @artist.update(artist_params)
      flash[:success] = "The artist was successfully updated."
      redirect_to artist_url(@artist)
    else
      render 'edit'
    end
  end

  def destroy
    @artist.destroy
    flash[:success] = "The artist was successfully deleted."
    redirect_to artists_url
  end

  private

  def artist_params
    params.require(:artist).permit(:first_name, :last_name, :birthyear, :biography, :nationality, :analysis, :thumbnail)
  end

  def find_artist
    @artist = Artist.find(params[:id])
  end
end
