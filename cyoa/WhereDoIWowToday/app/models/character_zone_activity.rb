class CharacterZoneActivity < ActiveRecord::Base
  validates_presence_of :character, :category
  belongs_to :character
  belongs_to :category
  belongs_to :quest
  belongs_to :achievement
  
  def zone
    category if category.zone?
  end

  def quest_count
    quest.nil? ? 0 : 1
  end
  
  def achievement_count
    achievement.nil? ? 0 : 1
  end
end
