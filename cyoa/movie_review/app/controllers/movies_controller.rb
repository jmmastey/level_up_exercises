class MoviesController < ApplicationController
  def new
  	@movie = Movie.find(params[:id])
  end
end
