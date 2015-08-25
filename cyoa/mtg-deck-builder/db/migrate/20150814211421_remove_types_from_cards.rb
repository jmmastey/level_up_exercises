class RemoveTypesFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :types
  end
end
