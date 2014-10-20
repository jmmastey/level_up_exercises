require "csv"
require "rake-progressbar"

namespace :export do
  desc "Inserts static information from dump files."

  task all: [:items, :regions, :stations]

  task items: :environment do
    ActiveRecord::Base.transaction do
      path = "db/items.csv"
      num_items = File.readlines(path).count
      progress_bar = create_progress_bar("Exporting items...", num_items)
      read_tab_delimited_file(path) do |row|
        item_id = row[0]
        name = row[1]
        Item.find_or_create_by(in_game_id: item_id) do |item|
          item.name = name
        end
        progress_bar.inc
      end
    end
  end

  task regions: :environment do
    ActiveRecord::Base.transaction do
      path = "db/regions.csv"
      num_regions = File.readlines(path).count
      progress_bar = create_progress_bar("Exporting regions...", num_regions)
      read_tab_delimited_file(path) do |row|
        region_id = row[0]
        name = row[2]
        Region.find_or_create_by(in_game_id: region_id) do |region|
          region.name = name
        end
        progress_bar.inc
      end
    end
  end

  task stations: :environment do
    ActiveRecord::Base.transaction do
      path = "db/stations.csv"
      num_stations = File.readlines(path).count
      progress_bar = create_progress_bar("Exporting stations...", num_stations)
      read_tab_delimited_file(path) do |row|
        station_id = row[0]
        name = row[2]
        Station.find_or_create_by(in_game_id: station_id) do |station|
          station.name = name
        end
        progress_bar.inc
      end
    end
  end

  def create_progress_bar(title, num_lines)
    puts title
    RakeProgressbar.new(num_lines)
  end

  def read_tab_delimited_file(filepath, &block)
    CSV.foreach(filepath,
                encoding: "bom|utf-8",
                headers: false,
                col_sep: "\t",
                &block)
  end
end
