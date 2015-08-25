class ChangeSetId < ActiveRecord::Migration
  def change
    rename_column :cards_mtg_sets, :set_id, :mtg_set_id
  end
end
