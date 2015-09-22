class Character < ActiveRecord::Base
  validates_presence_of :name, :realm
  validates_uniqueness_of :name, scope: :realm

  has_many :activities, dependent: :destroy
  has_many :quests, through: :activity

  def self.refresh_individual(name:, realm:)
    character = Character.find_by(name: name, realm: realm)
    return new_character(name, realm) if character.nil?
    character.update_from_blizzard! if character.updated_at < 1.hour.ago
    character
  end

  def self.new_character(name, realm)
    @api ||= Blizzard.new
    raw_info = @api.get_character_quests(name, realm)
    return if raw_info.nil?
    converted_info = convert_character(raw_info)
    character = Character.create!(converted_info)
    character.update_dependents(raw_info)
  end

  def self.convert_character(character_info)
    {
      name: character_info["name"],
      realm: character_info["realm"],
    }
  end
  private_class_method :convert_character

  def update_from_blizzard!
    @api ||= Blizzard.new
    raw_info = @api.get_character_quests(name, realm)
    return if raw_info.nil?
    update_dependents(raw_info)
  end

  def update_dependents(raw_info)
    completed_quests = raw_info["quests"]
    Quest.all.each do |quest|
      update_activities(quest, completed_quests)
    end
  end

  def update_activities(quest, completed_quests)
    if completed_quests.include?(quest.blizzard_id_num)
      destroy_where(quest: quest, character: self)
    else
      create_activities(quest)
    end
  end

  def destroy_where(args)
    activities = Activity.where(args)
    return if activities.empty?
    activities.each.map(&:destroy)
  end

  def create_activities(quest)
    quest.categories.each do |category|
      Activity.find_or_create(quest: quest, category: category, character: self)
    end
  end

  def zone_summaries
    activities = Activity.where(character_id: self[:id]) || []
    activities.each.with_object(empty_summaries) do |activity, summaries|
      summaries[activity.zone.name][:quest_count] += 1 unless activity.zone.nil?
    end
  end

  private

  def empty_summaries
    Category.all_zones.each.with_object({}) do |zone, summaries|
      summaries.merge! new_zero_summary(zone.name)
    end
  end

  def new_zero_summary(zone_name)
    id = Category.name_to_id(zone_name)
    { zone_name => { quest_count: 0, id: id } }
  end
end
