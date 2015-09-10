class Character < ActiveRecord::Base
  validates_presence_of :name, :realm
  validates_uniqueness_of :name , scope: :realm

  has_many :character_zone_activities, dependent: :destroy
  has_many :quests, through: :character_zone_activity
  has_many :achievements, through: :character_zone_activity

  ALLIANCE = 1
  HORDE = 2
  ALLIANCE_RACES = [1, # human
                    3, # dwarf
                    4, # night elf
                    7, # gnome
                    11, # draenei
                    22, # worgen
                    25, # alliance pandaren
                   ]

  
  def self.refresh_individual(name:, realm:)
    name = name.titleize
    character = Character.find_by(name: name, realm: realm)
    return new_character(name, realm) if character.nil?
    character.update_from_blizzard! if character.updated_at < 1.hour.ago
  end

  def self.new_character(name, realm)
    @api ||= Blizzard.new
    raw_info = @api.get_character(name, realm)
    return if raw_info.nil?
    converted_info = convert_character(raw_info)
    character = Character.create!(converted_info)
    character.update_dependents(raw_info)
  end

  def update_from_blizzard!
    @api ||= Blizzard.new
    raw_info = @api.get_character(name, realm)
    return if raw_info.nil?
    update_dependents(raw_info)    
  end

  def update_dependents(raw_info)
  end

  private

  def self.convert_character(character_info)
    faction = alliance_race?(character_info["race"]) ? ALLIANCE : HORDE
    {
      name: character_info["name"],
      realm: character_info["realm"],
      blizzard_faction_id_num: faction,
    }
  end

  def self.alliance_race?(race)
    ALLIANCE_RACES.include? race
  end

  public
  
  def zone_summaries
    czas = CharacterZoneActivity.where(character_id: self[:id]) || []
    czas.each.with_object(empty_summaries) do |cza, summaries|
      zone = cza.zone.name
      summaries[zone][:id] = cza.zone.id
      summaries[zone][:quest_count] += cza.quest_count
      summaries[zone][:achievement_count] += cza.achievement_count
    end
  end

  private
  
  def empty_summaries
    Category.all_zones.each.with_object({}) do |zone, summaries|
      summaries.merge! zero_summary(zone.name)
    end
  end

  def zero_summary(name)
    id = Category.name_to_id(name)
    { name => { quest_count: 0, achievement_count: 0, id: id } }
  end
end

### alliance races
# 1 human
# 3 dwarf
# 4 night elf
# 7 gnome
# 11 draenei
# 22 worgen
# 25 pandaren

### horde races
# 26 pandaren
