class Realm < ActiveRecord::Base
  def self.refresh
    if Realm.count > 0
      latest = Realm.all.order(:updated_at).last
      return if latest.updated_at > 1.day.ago
    end
    populate_from_blizzard
  end

  def self.populate_from_blizzard
    api = Blizzard.new
    raw_info = api.get_realm_status
    if raw_info.nil?
      return "Blizzard is currently unavailable.  Using stored realm list."
    end
    Realm.destroy_all
    populate_database(raw_info)
  end
  private_class_method :populate_from_blizzard

  def self.populate_database(raw_info)
    raw_info["realms"].each do |realm|
      Realm.create!(name: realm["name"], slug: realm["slug"])
    end
  end
  private_class_method :populate_database
end
