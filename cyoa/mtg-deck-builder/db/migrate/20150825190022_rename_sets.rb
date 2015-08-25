class RenameSets < ActiveRecord::Migration
  def change
    rename_table :sets, :mtg_sets
  end
end
