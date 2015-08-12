class DecksController < ApplicationController
  def show
    @deck = Deck.find(params[:id])
  end

  def new
    @deck = current_user.decks.build
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = "Your deck #{@deck.name} has been created."
      redirect_to @deck.user
    else
      render 'new'
    end
  end

  def edit
    @cards = Card.search_by_name(params[:cardname]).paginate(page: params[:page], per_page: 100)
    @deck = Deck.find(params[:id])
  end

  def destroy
  end

  private

  def deck_params
    params.require(:deck).permit(
      :name,
      :user_id)
  end
end
