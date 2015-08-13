class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :search_name
      t.integer :depth
      t.string :nodes
      t.string :edges

      t.timestamps null: false
    end
  end
end
