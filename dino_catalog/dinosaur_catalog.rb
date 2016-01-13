require "CSV"
require "JSON"

class DinosaurCatalog
  attr_accessor :json_file_name
  attr_accessor :default_keys

  def default_keys
    @default_keys = %w(name period continent diet walking weight description)
  end

  def initialize(attrs = {})
    @dinodex = []
    @json_file_name = 'dinodex.json'

    import_csv_files(attrs[:csv_files])

    parse_keys
  end

  def import_csv_files(files)
    files.map do |file_name|
      CSV.foreach(
        file_name, headers: true, header_converters: :symbol
      ) do |row|
        @dinodex << row.to_hash
      end
    end
  end

  def parse_keys
    @dinodex = @dinodex.map do |row|
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

  def find_large_dinosaurs
    find_by_weight(2000, 999_999_999)
  end

  def find_small_dinosaurs
    find_by_weight(1, 2000)
  end

  def find_by_weight(min_weight, max_weight)
    @dinodex.select do |row|
      row[:weight].to_i.between?(min_weight, max_weight)
    end
  end

  def find_bipeds
    find_dinos(:walking, "biped")
  end

  def find_carnivores
    find_dinos(:diet, "carnivore")
      .concat find_dinos(:diet, "insectivore")
      .concat find_dinos(:diet, "piscivore")
  end

  def find_by_period
    find_dinos(:period, time_period)
  end

  def find_dinos(key, value, catalog = nil)
    current_catalog = catalog ? catalog : @dinodex
    current_catalog.select do |row|
      row[key] && row[key].downcase == value
    end
  end

  def export_to_json
    File.open(@json_file_name, "w") do |f|
      f.write JSON.dump @dinodex
    end
  end
end
