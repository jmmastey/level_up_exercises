class Character < ActiveRecord::Base
  validates_presence_of :name, :realm
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
    character = Character.find_by(name: name, realm: realm)
    if character.nil?
      character = get_character_from_blizzard(name, realm)
    end
    return character
  end

  private
  
  def self.get_character_from_blizzard(name, realm)
    url = blizzard_url(name, realm)
    response = Blizzard.get(url)
    return if response.body.nil? || response.code != 200
    json_to_database_character(response.body)
  end

  def self.blizzard_url(name, realm)
    realm_name = Realm.name_for_url(realm)
    api_key = ENV['API_KEY']
    "/character/#{realm_name}/#{name}?apikey=#{api_key}"
  end
  
  def self.json_to_database_character(basic_info)
    parsed_basic_info = JSON.parse(basic_info)
    converted_info = convert_character(parsed_basic_info)
    Character.create!(converted_info)
  end

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
