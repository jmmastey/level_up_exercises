require 'csv'
require 'active_support'
require './lib/api_parser'

namespace :import_legislators do
  task create_legislators: :environment do
    CSV.foreach("./db/legislators.csv", headers: true) do |legislator|
      Legislator.find_or_create_by(legislator.to_h.slice(
                                    "title",
                                    "firstname",
                                    "lastname",
                                    "bioguide_id",
                                    "party",
                                    "state",
                                    "gender",
                                    "website",
                                    "twitter_id",
                                    "birthdate",
                                  ))
    end
  end
end

namespace :import_deeds do
  task create_deeds: :environment do
    congress_data = CongressApiParser.new
    begin
      all_bills = congress_data.all_bills
      all_bills.each do |deed|
        if legislator = Legislator.find_by(bioguide_id: deed[:bioguide_id])
          legislator.good_deeds << GoodDeed.find_or_create_by(deed.except(:bioguide_id))
          legislator.save
        end
      end
    rescue ArgumentError
      puts "API isn't working"
    end
  end
end
