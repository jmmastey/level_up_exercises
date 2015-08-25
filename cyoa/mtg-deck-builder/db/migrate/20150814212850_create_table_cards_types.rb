class CreateTableCardsTypes < ActiveRecord::Migration
  def change
    create_table :cards_types, id: false do |t|
      t.integer :card_id
      t.integer :type_id
    end
  end
end
