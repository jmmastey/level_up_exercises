class DecksController < ApplicationController
  def show
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

  def destroy
  end

  private

  def deck_params
    params.require(:deck).permit(
      :name,
      :user_id)
  end
end
