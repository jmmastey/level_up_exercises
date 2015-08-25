class AddAmountToCardsDecks < ActiveRecord::Migration
  def change
    add_column :cards_decks, :number_in_deck, :integer, default: 0
  end
end
