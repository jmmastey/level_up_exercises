class CreateCardsTable < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :color
      t.string :rarity
      t.string :format
      t.string :set
      t.string :type
      t.string :subtype
      t.string :supertype
      t.string :status
      t.boolean :multicolor
    end
  end
end
