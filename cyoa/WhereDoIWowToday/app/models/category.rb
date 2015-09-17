class Category < ActiveRecord::Base
  has_many :activities, dependent: :destroy
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
    activities = Activity.where(character: character, category: self)
    activities.collect(&:quest).compact
  end
end
