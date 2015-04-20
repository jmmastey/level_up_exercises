class MoviesController < ApplicationController
  def new
  	
  end

  def show
  	@movie = Movie.find(params[:id])
  	@reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
  end
end