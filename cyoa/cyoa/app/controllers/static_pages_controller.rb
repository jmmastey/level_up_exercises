class StaticPagesController < ApplicationController
  def home
    @artists = Artist.some
  end
end
