require_relative 'util/data_transformer'

require 'csv'
require 'json'

class DinoImporter
  attr_reader :dinos

  CONFIG = "config/data.json"

  def initialize
    @dinos = []
  end

  def import(config = CONFIG)
    data = data_from_sources(data_sources(config))
    @dinos.concat(data).sort_by! { |dino| dino['name'] }
  end

  private

  def csv_to_array(file)
    rows = CSV.read(filepath(file))
    keys = rows.shift
    [keys, rows]
  end

  def data_from_source(source)
    data = csv_to_array(source['file'])
    keysmap, valsmap = source.values_at("keysmap", "valuesmap")
    transform_data(keysmap, valsmap, data)
  end

  def data_from_sources(sources)
    sources.map do |source|
      keys, rows = data_from_source(source)
      format_data(keys, rows)
    end.flatten
  end

  def data_sources(file)
    JSON.parse(File.read(filepath(file)))
  end

  def filepath(file)
    File.join(File.expand_path(File.dirname(__FILE__)), file)
  end

  def format_data(keys, rows)
    rows.map { |row| row_to_hash(keys, row) }
  end

  def row_to_hash(keys, row)
    row.each_with_object({}).with_index do |(val, memo), idx|
      memo[keys[idx]] = val if val
    end
  end

  def transform_data(keysmap, valsmap, data)
    keys, values = data
    keys = transform_keys(DataTransformer.new(keysmap), keys)
    rows = transform_values(DataTransformer.new(valsmap), values)
    [keys, rows]
  end

  def transform_keys(key_transformer, keys)
    keys.map { |key| key_transformer.transform(key).downcase }
  end

  def transform_values(val_transformer, rows)
    rows.map do |row|
      row.map! { |val| val_transformer.transform(val) }
    end
  end
end
