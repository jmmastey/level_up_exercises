class ChartsController < ApplicationController
  def index
    @charts = Chart.all
  end
end
