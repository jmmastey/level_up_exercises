class AddIdToCardsDecks < ActiveRecord::Migration
  def change
    add_column :cards_decks, :id, :primary_key
  end
end
