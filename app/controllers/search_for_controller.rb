class SearchForController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def artist
    name = SearchForController.convert_artist_name_for_search(params[:search_query])
    artist = RetrieveArtist.new(name)
    return artist_not_found unless artist.record_exist?
    if artist.existing_record?
      flash[:notice] = "The artist already exists."
      redirect_to artists_path
    else
      artist.update_record
      flash[:success] = "The artist was successfully created."
      redirect_to artists_path
    end
  end

  private

  def self.convert_artist_name_for_search(name)
    name.gsub(/\s/, '-').downcase
  end

  def artist_not_found
    flash[:alert] = "Sorry. Your search returned no results."
    redirect_to artists_path
  end
end
