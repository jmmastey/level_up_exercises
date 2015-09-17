class Quest < ActiveRecord::Base
  MAX_BLIZZARD_QUEST_ID = 17_000

  KEY_MAPPINGS = { "id" => "blizzard_id_num",
                   "title" => "title",
                   "category" => "categories",
                   "reqLevel" => "req_level",
                   "level" => "level",
                   "faction_id" => "blizzard_faction_id_num" }

  validates_presence_of :blizzard_id_num
  validates_presence_of :title
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories
  has_many :character_zone_activites

  def self.populate_next_batch(count: 500)
    return if count < 1
    last_stored = Quest.order(:blizzard_id_num).last
    min_to_fetch = last_stored.nil? ? 1 : 1 + last_stored.blizzard_id_num
    max_to_fetch = min_to_fetch + count - 1
    populate_from_blizzard(min_blizzard_id: min_to_fetch,
                           max_blizzard_id: max_to_fetch)
  end

  def self.populate_from_blizzard(min_blizzard_id: 1,
                                  max_blizzard_id: MAX_BLIZZARD_QUEST_ID)
    api = Blizzard.new
    (min_blizzard_id..max_blizzard_id).each do |id|
      print "."
      response = api.get_quest(id)
      replace_quest(id.to_i, response)
    end
  end

  def self.replace_quest(blizzard_id_num, api_response)
    return if api_response.nil?
    destroy_by_blizzard_id_num(blizzard_id_num)
    create_quest(api_response)
  end
  private_class_method :replace_quest

  def self.destroy_by_blizzard_id_num(id)
    quest = Quest.find_by_blizzard_id_num(id)
    Quest.destroy(quest.id) unless quest.nil?
  end
  private_class_method :destroy_by_blizzard_id_num

  def self.create_quest(quest)
    converted_quest = convert_quest(quest)
    Quest.create!(converted_quest)
  end
  private_class_method :create_quest

  def self.convert_quest(quest)
    quest.each_with_object({}) do |key_val_pair, converted_quest|
      key = convert_key(key_val_pair[0])
      unless key.nil?
        value = convert_value(key, key_val_pair[1])
        converted_quest[key] = value
      end
    end
  end
  private_class_method :convert_quest

  def self.convert_key(possible_key)
    KEY_MAPPINGS.fetch(possible_key, nil)
  end
  private_class_method :convert_key

  def self.convert_value(converted_key, value)
    return value unless converted_key == "categories"
    category = Category.find_by(name: value) || Category.create!(name: value)
    [category]
  end
  private_class_method :convert_value
end
