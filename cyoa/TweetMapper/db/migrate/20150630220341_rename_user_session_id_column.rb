class RenameUserSessionIdColumn < ActiveRecord::Migration
  def change
    rename_column :user_sessions, :user_session_id, :session_key
  end
end
