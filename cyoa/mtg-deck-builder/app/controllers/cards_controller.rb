class CardsController < ApplicationController
  def index
    @cards = Card.paginate(page: params[:page], per_page: 50)
  end

  def show
    @card = Card.find_by_id(params[:id])
  end
end
