require "CSV"
require "JSON"

class DinosaurCatalog
  attr_accessor :files
  attr_accessor :json_file_name

  def initialize(attrs = {})
    @dinodex = []
    @json_file_name = 'dinodex.json'
    @files = Array(attrs[:catalogs])
    read_catalogs
    @dinodex = parse_keys
    set_current_catalog(@dinodex)
  end

  def read_catalogs
    @files.map do |file_name|
      CSV.foreach(
        file_name, headers: true, header_converters: :symbol
      ) do |row|
        @dinodex << row.to_hash
      end
    end
  end

  def parse_keys
    @dinodex.map do |row|
      parsed_row = {}
      row.each do |column, value|
        if column == :genus
          parsed_row[:name] = value
        elsif column == :weight_in_lbs
          parsed_row[:weight] = value
        elsif column == :carnivore
          parsed_row[:diet] = (value == 'Yes') ? 'Carnivore' : nil
        else
          parsed_row[column] = value
        end
      end
      parsed_row
    end
  end

  def dinodex_keys
    all_keys = []
    @dinodex.map do |row|
      all_keys += row.keys
    end
    all_keys.uniq
  end

  def dinodex_periods
    periods = []
    @dinodex.map do |row|
      periods << row[:period]
    end
    periods.uniq
  end

  def find_large_dinosaurs(catalog = nil)
    find_by_weight(2000, 999_999_999, catalog)
  end

  def find_small_dinosaurs(catalog = nil)
    find_by_weight(1, 2000, catalog)
  end

  def find_by_weight(min_weight, max_weight, catalog = nil)
    set_current_catalog(catalog)

    @current_catalog.select do |row|
      row[:weight].to_i.between?(min_weight, max_weight)
    end
  end

  def find_bipeds(catalog = nil)
    set_current_catalog(catalog)

    find_dinos(:walking, "biped")
  end

  def find_carnivores(catalog = nil)
    set_current_catalog(catalog)

    results = find_dinos(:diet, "carnivore")
    results.concat find_dinos(:diet, "insectivore")
    results.concat find_dinos(:diet, "piscivore")
    results
  end

  def find_by_period(catalog = nil)
    find_dinos(:period, time_period)
  end

  def find_dinos(key, value, catalog = nil)
    set_current_catalog(catalog ? catalog : @dinodex)
    @current_catalog.select do |row|
      row[key] && row[key].downcase == value
    end
  end

  def set_current_catalog(catalog = nil)
    @current_catalog = catalog ? catalog : @current_catalog
  end

  def export_to_json
    File.open(@json_file_name, "w") do |f|
      f.write JSON.dump @dinodex
    end
  end
end
