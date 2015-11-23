class CreatePlaneComponents < ActiveRecord::Migration
  def change
    create_table :plane_components do |t|
      t.references :plane, index: true, foreign_key: true
      t.references :component, index: true, foreign_key: true
      t.date :installation_date
      t.text :log

      t.timestamps null: false
    end
  end
end
