require_relative 'dino.rb'
require_relative 'interface.rb'
require_relative 'file_system.rb'
require_relative 'util/data_transformer.rb'
require_relative 'util/registry.rb'

class Dinodex
  CONFIG = {
    data: "config/data.json",
    help: "config/help.json",
    welcome: "views/welcome.txt",
  }

  def initialize
    @fs = FileSystem.new
    @registry = registry
    @cli = dino_cli

    @cli.read("dino:> ") until @cli.quit
  end

  private

  def data_from_file(config)
    data = @fs.csv_to_array(config["file"])
    keysmap, valsmap = config.values_at("keysmap", "valuesmap")
    transform_data(keysmap, valsmap, data)
  end

  def dino_cli
    Interface.new(@registry, help_msgs, welcome_msg)
  end

  def format_data(keys, rows)
    rows.map { |row| row_to_hash(keys, row) }
  end

  def get_data(configs)
    configs.inject([]) do |memo, config|
      keys, rows = data_from_file(config)
      format_data(keys, rows) + memo
    end
  end

  def help_msgs
    config = @fs.json_to_hash(CONFIG[:help])
    config.inject({}) do |memo, (key, val)|
      memo.merge(key => @fs.txt_to_string(val))
    end
  end

  def registry
    data = get_data(@fs.json_to_hash(CONFIG[:data]))
    registry = Registry.new(Dino)
    registry.register_all(data)
    registry
  end

  def row_to_hash(keys, row)
    row.each.with_index.inject({}) do |hash, (val, idx)|
      hash.merge(keys[idx] => val)
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

  def welcome_msg
    @fs.txt_to_string(CONFIG[:welcome])
  end
end

Dinodex.new
