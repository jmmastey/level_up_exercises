class Quest < ActiveRecord::Base
  validates_presence_of :blizzard_id_num
  has_many :categories
  has_many :character_zone_activites
  # has_many :objectives

  MAX_BLIZZARD_QUEST_ID = 9  # 99999999999 ?

  KEY_MAPPINGS = { "id" => "blizzard_id_num",
                   "title" => "title",
                   "category" => "category",
                   "reqLevel" => "req_level",
                   "level" => "level",
                   "faction_id" => "blizzard_faction_id_num"}

  def self.refresh_all(min_blizzard_id: 1,
                       max_blizzard_id: MAX_BLIZZARD_QUEST_ID)
    if Quest.count > 0
      latest = Quest.all.order(:updated_at).last
      return if latest.updated_at > 1.week.ago
    end
    populate_from_blizzard(min_blizzard_id: min_blizzard_id,
                           max_blizzard_id: max_blizzard_id)
  end

  private
  
  def self.populate_from_blizzard(min_blizzard_id: 1,
                                  max_blizzard_id: MAX_BLIZZARD_QUEST_ID)
    api = Blizzard.new
    (min_blizzard_id..max_blizzard_id).each do |id|
      print "."
      response = api.get_quest(id)
      unless response.nil?
        destroy_by_blizzard_id_num(id.to_i)
        create_quest(response)
      end
    end
  end

  def self.populate_next_batch(count: 500)
    latest_stored = Quest.order(:blizzard_id_num).last
    min_to_fetch = 1 + latest_stored.blizzard_id_num
    max_to_fetch = min_to_fetch + count
    populate_from_blizzard(min_blizzard_id: min_to_fetch,
                           max_blizzard_id: max_to_fetch)
  end
  
  private

  def self.destroy_by_blizzard_id_num(id)
    quest = Quest.find_by_blizzard_id_num(id)
    Quest.destroy(quest.id) unless quest.nil?
  end

  def self.create_quest(quest)
    converted_quest = convert_quest(quest)
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
