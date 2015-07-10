require "csv"
require "json"

class DinoCatalog
  attr_accessor :dinosaurs, :dino_files

  def initialize(dinosaurs: [], dino_files: nil)
    @dinosaurs = dinosaurs
    @dino_files = dino_files
    load_dino_files
  end

  def load_dino_files
    return if @dino_files.nil?
    @dino_files.each { |dino_file| @dinosaurs.concat(dino_file.read) }
  end

  def search_by_attr(dino_attr, desired_value)
    filter = DinoFilter.new(dino_attr, desired_value)
    filter.search(@dinosaurs)
  end

  def search_by_hash(hash)
    hash.inject(@dinosaurs) do |dinos, attr_value_pair|
      filter = DinoFilter.new(attr_value_pair[0], attr_value_pair[1])
      filter.search(dinos)
    end
  end

  def write_dinosaurs_as_json_file(path)
    path << ".json" unless path.include?(".json")
    File.open(path, mode: "w") do |file|
      file.write(JSON.generate(@dinosaurs))
    end
  end
end

class DinoFilter
  attr_accessor :dino_attr, :desired_value

  def initialize(dino_attr, desired_value)
    @dino_attr = dino_attr.to_s.downcase
    @desired_value = desired_value.to_s.downcase
  end

  def search(dinosaurs)
    if permissive_search?
      search_using_block(dinosaurs, ->(a, b) { a.include? b })
    else
      search_using_block(dinosaurs, ->(a, b) { a == b })
    end
  end

  def permissive_search?
    "period" == @dino_attr
  end

  def search_using_block(dinosaurs, block)
    dinos = dinosaurs.collect do |dino|
      attr_value = dino.method(@dino_attr).call
      downcase_attr_value = attr_value.to_s.downcase
      dino if block.call(downcase_attr_value, @desired_value)
    end
    dinos.compact
  end
end

class Dinosaur
  ATTRS = [:name, :period, :continent, :diet, :weight, :walking, :description]

  attr_accessor(*ATTRS)

  def initialize(options = {})
    @name = options[:name] || "template"
    @period = options[:period]
    @continent  = options[:continent]
    @diet = options[:diet]
    @weight = options[:weight]
    @walking = options[:walking]
    @description = options[:description]
  end

  def to_s
    strings = []
    ATTRS.each { |attr| strings << attr_to_s(attr) }
    strings.compact.join(', ')
  end

  def attr_to_s(attr)
    value = method(attr).call
    "#{attr.capitalize}: #{value}" unless value.nil?
  end

  def size
    return if @weight.nil?
    two_tons = 4000
    @weight.to_f > two_tons ? "big" : "small"
  end

  def carnivore?
    return if @diet.nil?
    diet = @diet.to_s.downcase
    %w(carnivore insectivore piscivore omnivore).include? diet
  end

  def carnivore
    carnivore?.to_s
  end

  def searchable_attrs
    attr_symbols = ATTRS + [:size, :carnivore]
    attr_symbols.collect(&:id2name)
  end

  # Defining comparison operators for easier testing with Minitest.
  def <=>(other)
    compare_by_attr_values(other)
  end

  def ==(other)
    compare_by_attr_values(other) == 0
  end

  def <(other)
    compare_by_attr_values(other) == -1
  end

  def >(other)
    compare_by_attr_values(other) == 1
  end

  def compare_by_attr_values(other)
    ATTRS.each do |attr|
      value = method(attr).call
      other_value = other.method(attr).call
      comparison = value <=> other_value
      return comparison unless comparison == 0
    end
    0
  end
end

class DinoFile
  attr_accessor :path, :reader

  def initialize(path, format)
    @path = path
    @reader = format_specific_reader(format)
  end

  def format_specific_reader(format)
    return nil unless [:original, :p_b_africa].include?(format)
    lambda do
      converter_method = method("#{format}_format_hash_to_dinosaur")
      csv_file_to_hashes.collect do |dino_hash|
        converter_method.call(dino_hash)
      end
    end
  end

  def read
    raise("Unknown format: #{@format}") if @reader.nil?
    @reader.call
  end

  def blank_to_nil_converter
    lambda do |field|
      field && field.empty? ? nil : field
    end
  end

  def csv_file_to_hashes
    CSV::Converters[:blank_to_nil] = blank_to_nil_converter
    options = { converters: :blank_to_nil, headers: true, return_headers: false,
                header_converters: [:downcase, :symbol] }
    CSV.open(@path, options) do |csv|
      csv.to_a.map(&:to_hash)
    end
  end

  def original_format_hash_to_dinosaur(dino_hash)
    dino_hash[:weight] = dino_hash[:weight_in_lbs]
    Dinosaur.new(dino_hash)
  end

  def p_b_africa_format_hash_to_dinosaur(dino_hash)
    dino_hash[:name] = dino_hash[:genus]
    dino_hash[:continent] = "Africa"
    return Dinosaur.new(dino_hash) unless dino_hash.key?(:carnivore)
    dino_hash[:diet] = dino_hash[:carnivore] ? "Carnivore" : "Herbivore"
    Dinosaur.new(dino_hash)
  end
end
