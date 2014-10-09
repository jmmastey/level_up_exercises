class StaticPagesController < ApplicationController
  def home
    @charts = Chart.all
  end
end
