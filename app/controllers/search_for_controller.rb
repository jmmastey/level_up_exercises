class SearchForController < ApplicationController

  def artist
    name = SearchForController.convert_artist_name_for_search(params[:search_query])
    artist = RetrieveArtist.new(name)
    if artist.new_record?
      artist.update_record
      flash[:success] = "The artist was successfully created."
      redirect_to artists_path
    else
      flash[:notice] = "The artist already exists."
      redirect_to artists_path
    end
  end

  private

  def self.convert_artist_name_for_search(name)
    name.gsub(/\s/, '-').downcase
  end
end
