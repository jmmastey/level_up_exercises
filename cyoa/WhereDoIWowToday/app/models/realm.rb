require 'logger'

class Realm < ActiveRecord::Base
  def self.name_for_url(name_for_humans)
    realm = Realm.find_by_name(name_for_humans)
    realm.nil? ? nil : realm.slug
  end

  def self.refresh
    if Realm.count > 0
      latest = Realm.all.order(:updated_at).last
      return if latest.updated_at > 1.day.ago
    end
    populate_from_blizzard(purge_if_response: true)
  end

  private

  def self.populate_from_blizzard(purge_if_response: false)
    api_key = ENV['API_KEY']
    response = Blizzard.get("/realm/status?apikey=#{api_key}")
    if response.code == 200 && !response.body.nil?
      Realm.destroy_all if purge_if_response
      json_to_database_realms(response.body)
    else
      log = Logger.new($stderr)
      log.error "Blizzard is currently unavailable.  Using stored realm list."
      return "Blizzard is currently unavailable.  Using stored realm list."
    end
  end

  def self.json_to_database_realms(realm_info)
    realms = JSON.parse(realm_info)["realms"]
    realms.each do |realm|
      Realm.create!(name: realm["name"], slug: realm["slug"])
    end
  end
end



# https://us.api.battle.net/wow/realm/status?apikey=<key>
# REALM STATUS API
# GET REALM STATUS /WOW/REALM/STATUS
# locale    en_US    string    What locale to use in the response
