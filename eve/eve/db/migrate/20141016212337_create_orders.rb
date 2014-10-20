class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :in_game_id
      t.decimal :security
      t.decimal :price
      t.string :type
      t.belongs_to :region
      t.belongs_to :station
      t.belongs_to :item

      t.timestamps null: false
    end

    add_index(:orders, :item_id)
    add_index(:orders, :in_game_id, unique: true)
    add_index(:orders, [:region_id, :station_id])
    add_index(:orders, :type)
  end
end
