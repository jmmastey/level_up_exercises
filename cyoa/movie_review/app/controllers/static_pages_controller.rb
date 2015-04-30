class StaticPagesController < ApplicationController
  def home
  	@movies = Movie.all
  end
 
  def news
  end
end
