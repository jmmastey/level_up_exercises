class CreateJoinTableCardType < ActiveRecord::Migration
  def change
    create_join_table :cards, :types do |t|
      t.index [:card_id, :type_id]
      t.index [:type_id, :card_id]
    end
  end
end
