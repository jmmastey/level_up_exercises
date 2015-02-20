require 'csv'
require 'active_support'
require './lib/api_parser'

namespace :import_legislators do
  task create_legislators: :environment do
    CSV.foreach("./db/legislators.csv", headers: true) do |legislator|
      Legislator.create(legislator.to_h.slice("title", "firstname", "lastname",
        "bioguide_id", "party", "state", "gender", "website", "twitter_id",
        "birthdate"))
    end
  end
end

namespace :import_deeds do
  task create_deeds: :environment do
    api = CongressApiParser.new
    deeds = api.bills(6)
    puts deeds.count
    deeds.each do |deed|
      puts deed["bioguide_id"]
      legislator = Legislator.find_by(bioguide_id: deed["bioguide_id"])
      if Legislator.find_by(bioguide_id: deed["bioguide_id"])
        legislator.good_deeds << GoodDeed.find_or_create_by(deed.except("bioguide_id"))
        legislator.save
      end
    end
  end
end