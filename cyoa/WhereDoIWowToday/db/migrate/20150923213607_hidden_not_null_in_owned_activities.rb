class HiddenNotNullInOwnedActivities < ActiveRecord::Migration
  def change
    change_column :owned_activities, :hidden, :boolean, null: false,
                  default: false
  end
end
