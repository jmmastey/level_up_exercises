class CharacterZoneActivity < ActiveRecord::Base
  validates_presence_of :character, :category
  validates_uniqueness_of :character, scope: [:category, :quest]
  belongs_to :character
  belongs_to :category
  belongs_to :quest

  def zone
    category if category.zone?
  end

  def quest_count
    quest.nil? ? 0 : 1
  end

  def self.find_or_create(args)
    CharacterZoneActivity.find_by(args) || CharacterZoneActivity.create!(args)
  end
end
