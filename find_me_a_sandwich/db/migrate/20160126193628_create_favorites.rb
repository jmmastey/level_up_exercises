class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|

      t.timestamps null: false
      t.references :user, required: true
      t.references :menu_item, required: true
    end
  end
end
