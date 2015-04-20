class StaticPagesController < ApplicationController
  def home
  	@movies = Movie.all
  end

  def help
  end

  def news
  end
end
