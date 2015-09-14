class Category < ActiveRecord::Base
  has_many :character_zone_activities, dependent: :destroy
  has_and_belongs_to_many :quests

  def zone?
    self[:blizzard_type].eql?('zone')
  end

  def self.all_zones
    Category.where(blizzard_type: 'zone')
  end

  def self.name_to_id(name)
    Category.find_by_name(name).id
  end

  def character_quests(character_id)
    return quests if character_id.nil?
    character = Character.find(character_id)
    czas = CharacterZoneActivity.where(character: character, category: self)
    czas.collect(&:quest).compact
  end
end
