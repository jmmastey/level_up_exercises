class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_id, limit: 40
      t.datetime :last_activity

      t.timestamps null: false
    end
  end
end
