class AddFavoritesRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :favorite, index: true
    add_foreign_key :users, :favorites
  end
end
