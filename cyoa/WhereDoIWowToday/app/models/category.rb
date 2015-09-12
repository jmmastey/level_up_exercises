class Category < ActiveRecord::Base
  has_many :character_zone_activities, dependent: :destroy
  has_and_belongs_to_many :quests
  has_many :achievements, through: :character_zone_activity
  
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
    return [] if character_id.nil?
    quests = []
    character_zone_activities.each do |cza|
      if cza.character.id == character_id
        quests << cza.quest
      end
    end
    quests.compact
  end

  def character_achievements(character_id)
    []
  end
end
