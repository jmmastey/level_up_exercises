$LOAD_PATH << '.'

require 'csv'
require 'dinosaur'

class DinosaurImport
  attr_accessor :dinosaurs

  DEFAULT_OPTIONS = {
    headers: true,
    col_sep: ','
  }

  def initialize(csv_files)
    dinosaurs = []
    csv_files.each do |csv_file|
      data = CSV.read(csv_file,DEFAULT_OPTIONS)
      data.each do |row|
        dinosaur = {}
        row.to_hash.each_pair do |key,value|
          key_converted = DinosaurImport::convert_import_keys(key)
          value_converted = DinosaurImport::convert_import_values(key_converted, value)
          dinosaur.merge!({key_converted => value_converted})
        end
        dinosaurs << Dinosaur.new(dinosaur)
        end
    end
    @dinosaurs = dinosaurs
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
        value_converted = value_convert_hash[value]
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
                'No' => nil},
    'period' => {'Early Cretaceous' => 'Cretaceous',
                'Late Cretaceous' => 'Cretaceous'} }
  end

end