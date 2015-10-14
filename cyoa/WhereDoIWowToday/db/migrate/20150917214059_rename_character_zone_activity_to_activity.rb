class RenameCharacterZoneActivityToActivity < ActiveRecord::Migration
  def change
    rename_table :character_zone_activities, :activities
  end
end
