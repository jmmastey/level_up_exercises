class CreateDecksCards < ActiveRecord::Migration
  def change
    create_table :cards_decks, id: false do |t|
      t.integer :card_id
      t.integer :deck_id
    end
  end
end
