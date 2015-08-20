class ChangeShowParent < ActiveRecord::Migration
  def change
    rename_column :shows, :channel_id, :search_id
  end
end
