class ChangeDefaultNotificationActiveToTrue < ActiveRecord::Migration
  def up
    change_column_default :user_notifications, :active, true
  end

  def down
    change_column_default :user_notifications, :active, false
  end
end
