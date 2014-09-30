class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.string :icon

      t.timestamps null: false
    end
  end
end
