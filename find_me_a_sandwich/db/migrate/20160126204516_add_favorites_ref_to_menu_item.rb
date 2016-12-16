class AddFavoritesRefToMenuItem < ActiveRecord::Migration
  def change
    add_reference :menu_items, :favorite, index: true
    add_foreign_key :menu_items, :favorites
  end
end
