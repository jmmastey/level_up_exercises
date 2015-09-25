class Category < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_and_belongs_to_many :quests

  def zone?
    self[:blizzard_type].eql?('zone')
  end

  def character_activities(character)
    Activity.where(character: character, category: self)
  end

  def self.all_zones
    Category.where(blizzard_type: 'zone')
  end

  def self.name_to_id(name)
    Category.find_by_name(name).id
  end
end
