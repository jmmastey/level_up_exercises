class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :external_id
      t.string :name, required: true
      t.string :group
      t.string :subgroup
      t.string :description
      t.decimal :price, precision: 8, scale: 2
      t.boolean :active, default: true
      t.references :menu, required: true

      t.timestamps null: false
    end
  end
end
