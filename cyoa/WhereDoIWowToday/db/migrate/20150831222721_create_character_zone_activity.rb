class CreateCharacterZoneActivity < ActiveRecord::Migration
  def change
    create_table :character_zone_activities do |t|
      t.references :character, index: true
      t.references :category, index: true
      t.references :quest, index: true
      t.references :achievement, index: true
    end
    add_foreign_key :character_zone_activities, :characters
    add_foreign_key :character_zone_activities, :categories
    add_foreign_key :character_zone_activities, :quests
    add_foreign_key :character_zone_activities, :achievements
  end
end
