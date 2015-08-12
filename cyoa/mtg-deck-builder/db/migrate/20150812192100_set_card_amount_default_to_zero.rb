class SetCardAmountDefaultToZero < ActiveRecord::Migration
  def change
    change_column :cards_decks, :number_in_deck, :integer, :default => 0
  end
end
