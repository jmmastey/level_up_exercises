class CreateCardsSets < ActiveRecord::Migration
  def change
    create_table :cards_sets, id: false do |t|
      t.integer :card_id
      t.integer :set_id
    end
  end
end
