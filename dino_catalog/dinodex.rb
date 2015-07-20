require 'json'
require_relative 'dinoparser'

class Dinosaur
  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def has?(key)
    @data.include?(key)
  end

  def name_is?(name)
    @data['name'] == name if has?('name')
  end

  def from_period?(period)
    @data['period'].include?(period) if has?('period')
  end

  def diet_is?(diet)
    return carnivore? if diet == 'carnivore'
    @data['diet'] == diet if has?('diet')
  end

  def carnivore?
    @data['diet'] != 'herbivore' && !@data['diet'].empty? if has?('diet')
  end

  def size_is?(size)
    return false if !has?('weight') || has?('weight') && @data['weight'].empty?
    return Float(@data['weight']) >= 2000 if size == 'big'
    return Float(@data['weight']) < 2000 if size == 'small'
  end

  def walking_is?(walking)
    @data['walking'] == walking if has?('walking')
  end

  def to_s
    max_len = @data.keys.max_by(&:length).length
    @data.each do |k, v|
      spaces = ' ' * (max_len - k.length) + ' '
      puts k + ':' + spaces + v if v.length > 0
    end
  end
end

class Dinodex
  SEARCH_NAME = lambda do |res, name|
    res.select { |dino| dino.name_is?(name) }
  end

  SEARCH_PERIOD = lambda do |res, period|
    res.select { |dino| dino.from_period?(period) }
  end

  SEARCH_DIET = lambda do |res, diet|
    res.select { |dino| dino.diet_is?(diet) }
  end

  SEARCH_SIZE = lambda do |res, size|
    res.select { |dino| dino.size_is?(size) }
  end

  SEARCH_WALKING = lambda do |res, walking|
    res.select { |dino| dino.walking_is?(walking) }
  end

  SEARCH_DISPATCHER = {
    name: SEARCH_NAME,
    period: SEARCH_PERIOD,
    diet: SEARCH_DIET,
    size: SEARCH_SIZE,
    walking: SEARCH_WALKING,
  }

  attr_accessor :registry

  def initialize
    @registry = []
  end

  def load_data(data)
    data.each do |row|
      @registry << Dinosaur.new(row)
    end
  end

  def load_csv(filename)
    return false unless File.file?(filename)
    data = DinoTranslator.translate(DinoParser.parse_csv(filename))
    load_data(data) if DinoValidator.valid_data?(data)
  end

  def search(args = {}, results = @registry)
    args.each do |k, v|
      results = SEARCH_DISPATCHER[k].call(results, v)
    end
    results
  end

  def print_search(args = {})
    res = search(args)
    DinodexPrinter.print(res)
  end

  def export_json(results = @registry)
    { "dinosaurs" => results.map(&:data) }.to_json
  end

  def to_s(subset = @registry)
    DinodexPrinter.print(subset)
  end
end

module DinodexPrinter
  COLUMN_MAX_LENGTHS = lambda do
    {
      'name' => 0,
      'period' => 0,
      'continent' => 0,
      'diet' => 0,
      'weight' => 0,
      'walking' => 0,
      'description' => 0,
    }
  end

  def self.build_table_header(columns)
    header = "|"
    columns.each do |key, max_len|
      spaces = " " * (max_len - key.length) + " |"
      header += " " + key + spaces
    end
    header
  end

  def self.build_cell(dino, key, max_len)
    data = dino.has?(key) ? dino.data[key] : ""
    data_len = dino.has?(key) ? dino.data[key].length : 0
    spaces = "." * (max_len - data_len) + " |"
    " " + data + spaces
  end

  def self.build_table_row(dino, columns)
    row = "|"
    columns.each { |key, max_len| row += build_cell(dino, key, max_len) }
    row += "\n"
  end

  def self.build_table_body(subset, columns)
    body = ""
    subset.each { |dino| body += build_table_row(dino, columns) }
    body
  end

  def self.calc_max_column_lengths(subset)
    columns_max_len = COLUMN_MAX_LENGTHS.call
    columns_max_len.keys.each do |key|
      dino = subset.max_by { |d| d.has?(key) ? d.data[key].length : 0 }
      next unless dino.has?(key)
      columns_max_len[key] = dino.data[key].length
    end
    columns_max_len
  end

  def self.calc_column_lengths(subset)
    columns_max_len = calc_max_column_lengths(subset)
    remove_blank_columns(columns_max_len)
  end

  def self.remove_blank_columns(columns_max_len)
    columns_max_len.keys.each do |key|
      columns_max_len.delete key if columns_max_len[key] == 0
      next if columns_max_len[key] == 0
      v = columns_max_len[key]
      columns_max_len[key] = v > key.length ? v : key.length
    end
    columns_max_len
  end

  def self.print(subset)
    columns = calc_column_lengths(subset)
    header = build_table_header(columns)
    body = build_table_body(subset, columns)

    puts header
    puts '-' * header.length
    puts body
  end
end

dinodex = Dinodex.new
ARGV.each do |arg|
  dinodex.load_csv(arg)
end

# exit if dinodex.registry.empty?

puts "\nAll the bipeds:"
dinodex.print_search(walking: 'biped')

puts "\nAll the carnivores:"
dinodex.print_search(diet: 'carnivore')

puts "\nAll the dinosaurs from the cretaceous period:"
dinodex.print_search(period: 'cretaceous')

puts "\nAll the big dinosaurs:"
dinodex.print_search(size: 'big')

puts "\nAll the small dinosaurs:"
dinodex.print_search(size: 'small')
