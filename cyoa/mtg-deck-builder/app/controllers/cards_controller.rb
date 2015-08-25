class CardsController < ApplicationController
  def index
    @cards = Card.paginate(page: params[:page], per_page: 30)
  end

  def show
  end
end
