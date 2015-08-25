class CardsController < ApplicationController
  def index
    @cards = Card.search(params).paginate(page: params[:page], per_page: 50)
  end

  def show
    @card = Card.find(params[:id])
  end

  def show_tooltip
    @card = Card.find(params[:id])
    render 'cards/show_tooltip', layout: false
  end
end
