class Quest < ActiveRecord::Base
  validates_presence_of :blizzard_id_num
  has_many :categories
  has_many :character_zone_activites
  # has_many :objectives

  MAX_POSSIBLE_BLIZZARD_QUEST_ID = 9  # 99999999999 ?

  KEY_MAPPINGS = { "id" => "blizzard_id_num",
                   "title" => "title",
                   "category" => "category",
                   "reqLevel" => "req_level",
                   "level" => "level",
                   "faction_id" => "blizzard_faction_id_num"}

  def self.refresh
    if Quest.count > 0
      latest = Quest.all.order(:updated_at).last
      return if latest.updated_at > 1.week.ago
    end
    populate_from_blizzard(purge_if_response: true)
  end

  private
  
  def self.populate_from_blizzard(purge_if_response: false)
    api_key = ENV['API_KEY']
    (1..MAX_POSSIBLE_BLIZZARD_QUEST_ID).each do |id|
      response = Blizzard.get("/quest/#{id}?apikey=#{api_key}")
      break unless response.code == 200
      if purge_if_response
        quest = Quest.find_by_blizzard_id_num(id.to_i)
        Quest.destroy(quest.id) unless quest.nil?
      end
      json_to_database_quest(response.body)      
    end
  end

  private

  def self.json_to_database_quest(quest)
    parsed_quest = JSON.parse(quest)
    converted_quest = convert_quest(parsed_quest)
    Quest.create!(converted_quest)
  end

  def self.convert_quest(quest)
    quest.each_with_object({}) do |key_val_pair, converted_quest|
      key = convert_key(key_val_pair[0])
      converted_quest[key] = key_val_pair[1] unless key.nil?
    end
  end
  
  def self.convert_key(possible_key)
    KEY_MAPPINGS.fetch(possible_key, nil)
  end
end


#GET QUEST /WOW/QUEST/:QUESTID
# https://us.api.battle.net/wow/quest/:questid?apikey=<key>
