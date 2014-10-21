class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.string :nickname
      t.references :item, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
