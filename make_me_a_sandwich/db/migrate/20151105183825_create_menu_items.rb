class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :external_id
      t.string :name, required: true
      t.string :group
      t.string :subgroup
      t.string :description
      t.boolean :active, default: true
      t.references :menu, required: true

      t.timestamps null: false
    end
  end
end
