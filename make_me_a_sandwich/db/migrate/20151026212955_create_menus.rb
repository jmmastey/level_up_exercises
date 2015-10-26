class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :external_id
      t.string :name
      t.string :description
      t.references :merchant

      t.timestamps null: false
    end
  end
end
