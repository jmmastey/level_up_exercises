class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end

end
