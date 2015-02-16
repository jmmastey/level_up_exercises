require 'csv'
require 'active_support'

namespace :import_legislators do
  task create_legislators: :environment do
    CSV.foreach("./db/legislators.csv", headers: true) do |legislator|
      Legislator.create(legislator.to_h.slice("title", "firstname", "lastname",
        "party", "state", "gender", "website", "twitter_id", "birthdate"))
    end 
  end
end