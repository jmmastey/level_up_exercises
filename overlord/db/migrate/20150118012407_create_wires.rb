class CreateWires < ActiveRecord::Migration
  def change
    create_table :wires do |t|
      t.string :color
      t.boolean :diffuse, default: false
      t.integer :bomb_id
    end
  end
end
