require "csv"

namespace :export do
  desc "Inserts static information from text files."

  task items: :environment do
    ActiveRecord::Base.transaction do
      CSV.foreach("db/items.txt", encoding: "bom|utf-8", headers: false, col_sep: "\t") do |row|
        item_id = row[0]
        name = row[1]
        Item.find_or_create_by(in_game_id: item_id) do |item|
          item.name = name
        end
      end
    end
  end

  task locations: :environment do
    ActiveRecord::Base.transaction do
      CSV.foreach("db/locations.txt", encoding: "bom|utf-8", headers: false, col_sep: "\t") do |row|
        location_id = row[0]
        name = row[2]
        Location.find_or_create_by(in_game_id: location_id) do |location|
          location.name = name
        end
      end
    end
  end
end
