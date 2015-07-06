class AddCoordsAndRadiusToUserSessions < ActiveRecord::Migration
  def change
    UserSession.delete_all
    add_column :user_sessions, :latitude, :decimal, precision: 10, scale: 6, null: false
    add_column :user_sessions, :longitude, :decimal, precision: 10, scale: 6, null: false
    add_column :user_sessions, :miles_radius, :decimal, precision: 10, scale: 6, null: false
  end
end
