class MoviesController < ApplicationController
  def new
  	
  end

  def show
  	@movie = Movie.find(params[:id])
  	@reviews = Review.where(movie_id: @movie.id).order("created_at DESC")

  	if @reviews.blank?
  		@avg_rating = 0
  	else
  		@avg_rating = @reviews.average(:rating).round(2)
  	end
  end
end
