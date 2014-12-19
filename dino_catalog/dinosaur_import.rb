$LOAD_PATH << '.'

require 'csv'
require 'dinosaur'

class DinosaurImport
  attr_accessor :dinosaurs

  DEFAULT_OPTIONS = {
    headers: true,
    col_sep: ',',
  }
  AUTOCONVERT_KEYS = {
    "genus" => "name",
    "weight_in_lbs" => "weight",
    "carnivore" => "diet",
  }
  AUTOCONVERT_KEYS_VALUES = {
    "diet" => { "Yes" => "Carnivore",
                "No" => nil }
  }

  def initialize(csv_files)
    csv_files_to_dinosaurs(csv_files)
  end

  private

  def csv_files_to_dinosaurs(csv_files)
    new_dinosaurs = []
    csv_files.each do |csv_file|
      data = CSV.read(csv_file, DEFAULT_OPTIONS)
      dinosaurs_from_data = data_to_dinosaurs(data)
      new_dinosaurs.concat(dinosaurs_from_data)
    end
    @dinosaurs = new_dinosaurs
  end

  def data_to_dinosaurs(data)
    dinosaurs_from_data = []
    data.each do |row|
      hash = row.to_hash
      hash = convert_import_hash(hash)
      dinosaurs_from_data << Dinosaur.new(hash)
    end
    dinosaurs_from_data
end

  def convert_import_hash(hash)
    hash_converted = {}
    hash.each_pair do |key, value|
      key_converted = convert_import_keys(key)
      value_converted = convert_import_values(key_converted, value)
      hash_converted.merge!(key_converted => value_converted)
    end
    hash_converted
  end

  def convert_import_keys(key)
    AUTOCONVERT_KEYS.fetch(key.downcase, key.downcase)
  end

  def convert_import_values(key_converted, value)
    if AUTOCONVERT_KEYS_VALUES.key?(key_converted)
      value_convert_hash = AUTOCONVERT_KEYS_VALUES[key_converted]
      value_convert_hash.fetch(value, value)
    else
      value
    end
  end
end
