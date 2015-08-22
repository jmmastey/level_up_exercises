class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :artist
      t.integer :depth
      t.string :nodes
      t.string :edges

      t.timestamps null: false
    end
  end
end
