class RenameSessionIdColumn < ActiveRecord::Migration
  def change
    rename_column :sessions, :session_id, :user_session_id
  end
end
