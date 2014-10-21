class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @artists = current_user.artists
  end
end
