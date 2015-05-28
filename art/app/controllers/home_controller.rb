class HomeController < ApplicationController
  def trending
    @shows = Show.trending
  end
end
