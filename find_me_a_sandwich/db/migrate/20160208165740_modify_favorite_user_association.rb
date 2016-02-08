class ModifyFavoriteUserAssociation < ActiveRecord::Migration
  def change
    remove_column :menu_items, :favorite
  end
end
