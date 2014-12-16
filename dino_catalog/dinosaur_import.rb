$LOAD_PATH << '.'

require 'csv'
require 'dinosaur'

class DinosaurImport
  attr_accessor :dinosaurs, :csv_files, :data

  DEFAULT_OPTIONS = {
    headers: true,
    col_sep: ',',
  }

  def initialize(csv_files)
    @csv_files = csv_files
    csv_files_to_dinosaurs
  end

  def csv_files_to_dinosaurs
    dinosaurs = []
    @csv_files.each do |csv_file|
      @data = CSV.read(csv_file,DEFAULT_OPTIONS)
      dinosaurs_from_file = data_to_dinosaurs
      dinosaurs.concat(dinosaurs_from_file)
    end
    @dinosaurs = dinosaurs
  end

  def data_to_dinosaurs
    dinosaurs = []
    @data.each do |row|
      hash = row.to_hash
      hash = DinosaurImport::convert_import_hash(hash)
      dinosaurs << Dinosaur.new(hash)
    end
    dinosaurs
  end

  def self.convert_import_hash(hash)
    hash_converted = {}
    hash.each_pair do |key, value|
      key_converted = DinosaurImport::convert_import_keys(key)
      value_converted =
          DinosaurImport::convert_import_values(key_converted, value)
      hash_converted.merge!({key_converted => value_converted})
    end
    hash_converted
  end

  def self.convert_import_keys(key)
    key_converted = key.downcase
    if self.autoconvert_keys.has_key?(key_converted)
      self.autoconvert_keys[key_converted]
    else
      key_converted
    end
  end

  def self.convert_import_values(key_converted,value)
    if self.autoconvert_keys_values.has_key?(key_converted)
      value_convert_hash = self.autoconvert_keys_values[key_converted]
      if value_convert_hash.has_key?(value)
        value_convert_hash[value]
      else
        value
      end
    else
      value
    end
  end

  def self.autoconvert_keys
    { 'genus' => 'name',
      'weight' => 'weight_in_lbs',
      'carnivore' => 'diet'
    }
  end

  def self.autoconvert_keys_values
    {'diet' => {'Yes' => 'Carnivore',
                'No' => nil} }
  end

end