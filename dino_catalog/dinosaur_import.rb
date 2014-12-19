require 'csv'
require_relative 'dinosaur'

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
                "No" => nil },
  }

  def initialize(csv_files)
    csv_files_to_dinosaurs(csv_files)
  end

  private

  def csv_files_to_dinosaurs(csv_files)
    self.dinosaurs = csv_files.map { |csv_file| data_to_dinosaurs(csv_file) }.flatten
  end

  def data_to_dinosaurs(csv_file)
    CSV.read(csv_file, DEFAULT_OPTIONS).map { |row| row_to_dinosaur(row) }
  end

  def row_to_dinosaur(row)
    Dinosaur.new(convert_import_hash(row.to_hash))
  end

  def convert_import_hash(hash)
    Hash[hash.map { |key, value| convert_import_key_value(key, value) }]
  end

  def convert_import_key_value(key, value)
    key_converted = convert_import_key(key)
    [key_converted, convert_import_value(key_converted, value)]
  end

  def convert_import_key(key)
    AUTOCONVERT_KEYS.fetch(key.downcase, key.downcase)
  end

  def convert_import_value(key_converted, value)
    return value unless AUTOCONVERT_KEYS_VALUES.key?(key_converted)
    AUTOCONVERT_KEYS_VALUES[key_converted].fetch(value, value)
  end
end
