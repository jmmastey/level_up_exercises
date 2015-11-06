class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :external_id
      t.string :name, required: true
      t.string :description
      t.references :merchant, required: true

      t.timestamps null: false
    end
  end
end
