require "CSV"
require "JSON"

class DinosaurCatalog
  attr_accessor :files
  attr_accessor :json_file_name
  attr_accessor :default_keys

  def default_keys
    @default_keys = %w(name period continent diet walking weight description)
  end

  def initialize(attrs = {})
    @dinodex = []
    @json_file_name = 'dinodex.json'
    @files = Array(attrs[:csv_files])
    import_csv_files
    @dinodex = parse_keys
    set_current_catalog(@dinodex)
  end

  def import_csv_files
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
      row.merge(@default_keys.to_h)
      row[:name] = row[:genus] unless row[:name]
      row[:weight] = row[:weight_in_lbs] unless row[:weight]
      row[:diet] = 'Carnivore' if !row[:diet] && row[:carnivore] == 'Yes'
      row
    end
  end

  def dinodex_periods
    @dinodex.map do |row|
      row[:period]
    end.uniq
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

  def find_by_period
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
