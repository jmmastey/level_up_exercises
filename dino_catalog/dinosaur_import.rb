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
    'genus' => 'name',
    'weight' => 'weight_in_lbs',
    'carnivore' => 'diet',
  }
  AUTOCONVERT_KEYS_VALUES = {
    'diet' => { 'Yes' => 'Carnivore',
                'No' => nil }
  }

  def initialize(csv_files)
    csv_files_to_dinosaurs(csv_files)
  end

  private

  def csv_files_to_dinosaurs(csv_files)
    dinosaurs = []
    csv_files.each do |csv_file|
      data = CSV.read(csv_file, DEFAULT_OPTIONS)
      dinosaurs_from_file = data_to_dinosaurs(data)
      dinosaurs.concat(dinosaurs_from_file)
    end
    @dinosaurs = dinosaurs
  end

  def data_to_dinosaurs(data)
    dinosaurs = []
    data.each do |row|
      hash = row.to_hash
      hash = self.class.convert_import_hash(hash)
      dinosaurs << Dinosaur.new(hash)
    end
    dinosaurs
  end

  class << self

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
      key_converted = key.downcase
      if AUTOCONVERT_KEYS.key?(key_converted)
        AUTOCONVERT_KEYS[key_converted]
      else
        key_converted
      end
    end

    def convert_import_values(key_converted, value)
      if AUTOCONVERT_KEYS_VALUES.key?(key_converted)
        value_convert_hash = AUTOCONVERT_KEYS_VALUES[key_converted]
        value_convert_hash.key?(value) ? value_convert_hash[value] : value
      else
        value
      end
    end

  end
end
