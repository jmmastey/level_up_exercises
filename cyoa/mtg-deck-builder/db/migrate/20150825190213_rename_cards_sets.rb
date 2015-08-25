class RenameCardsSets < ActiveRecord::Migration
  def change
    rename_table :cards_sets, :cards_mtg_sets
  end
end
