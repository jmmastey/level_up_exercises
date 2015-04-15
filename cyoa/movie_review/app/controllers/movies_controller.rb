class MoviesController < ApplicationController
  def new
  	@movie = Movie.first
  end
end
