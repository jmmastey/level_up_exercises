class StaticPagesController < ApplicationController
  def home
  	@movies = Movie.all
  end

  def help
  end
end
