class RemoveHiddenFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :hidden, :boolean
  end
end
