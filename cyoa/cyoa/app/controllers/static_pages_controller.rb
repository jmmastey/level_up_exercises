class StaticPagesController < ApplicationController
  def home
    @artists = Artist.defaults
  end
end
