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
    return if dino_files.nil?
    dino_files.each { |file| dinosaurs.concat(file.read) }
  end

  def search_by_attr(dino_attr, desired_value)
    filter = DinoFilter.new(dino_attr, desired_value)
    filter.search(dinosaurs)
  end

  def search_by_multiple_attrs(attr_requirements)
    attr_requirements.each_with_object(dinosaurs) do |attr_value_pair, dinos|
      filter = DinoFilter.new(attr_value_pair[0], attr_value_pair[1])
      dinos.replace(filter.search(dinos))
    end
  end

  def export_as_json(path)
    dinos = dinosaurs.each.map(&:to_h)
    path << ".json" unless path.include?(".json")
    File.open(path, mode: "w") do |file|
      file.write(JSON.generate(dinos))
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
      specialized_search(dinosaurs, ->(a, b) { a.include? b })
    else
      specialized_search(dinosaurs, ->(a, b) { a == b })
    end
  end

  def permissive_search?
    "period" == dino_attr
  end

  def specialized_search(dinosaurs, block)
    dinosaurs.find_all do |dino|
      attr_value = dino.method(dino_attr).call
      downcase_attr_value = attr_value.to_s.downcase
      block.call(downcase_attr_value, desired_value)
    end
  end
end

class Dinosaur
  CARNIVORES = %w(carnivore insectivore piscivore omnivore)
  TWO_TONS = 4000

  ATTRS = [:name, :period, :continent, :diet, :weight, :walking, :description]
  ATTRS.freeze
  attr_accessor(*ATTRS)

  def initialize(options = {})
    @name = options[:name]
    @period = options[:period]
    @continent  = options[:continent]
    @diet = options[:diet]
    @weight = options[:weight]
    @walking = options[:walking]
    @description = options[:description]
  end

  def to_s
    strings = ATTRS.each_with_object([]) { |attr, str| str << attr_to_s(attr) }
    strings.compact.reject(&:empty?).join(', ')
  end

  def attr_to_s(attr)
    value = method(attr).call
    return "" if value.nil?
    "#{attr.capitalize}: #{value}"
  end

  def size
    return if weight.nil?
    weight.to_f > TWO_TONS ? "big" : "small"
  end

  def carnivore?
    return false if diet.nil?
    CARNIVORES.include? diet.to_s.downcase
  end

  def carnivore
    carnivore?.to_s
  end

  def searchable_attrs
    attr_symbols = ATTRS + [:size, :carnivore]
    attr_symbols.map(&:id2name)
  end

  def to_h
    ATTRS.each_with_object({}) do |attr, h|
      value = method(attr).call
      h["#{attr.capitalize}"] = value unless value.nil?
    end
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

class DinoBadFormat < StandardError
end

class DinoFile
  attr_accessor :path, :reader

  HEADER_FORMATS = {
    "genus,period,carnivore,weight,walking" => :p_b_africa,
    "name,period,continent,diet,weight_in_lbs,walking,description" => :original,
  }

  def initialize(path: nil)
    @path = path
    @reader = format_specific_reader unless path.nil?
  end

  def format_specific_reader
    format = identify_format
    lambda do
      converter_method = method("#{format}_format_to_dinosaur")
      csv_file_to_h.map do |dino|
        converter_method.call(dino)
      end
    end
  end

  def identify_format
    File.open(path) do |file|
      line = file.readline
      sanitized_line = line.downcase.strip
      format = HEADER_FORMATS[sanitized_line]
      raise(DinoBadFormat, "Unknown format in file: #{path}") if format.nil?
      format
    end
  end

  def read
    reader.call
  end

  def blank_to_nil_converter
    lambda do |field|
      field && field.empty? ? nil : field
    end
  end

  def csv_file_to_h
    CSV::Converters[:blank_to_nil] = blank_to_nil_converter
    options = { converters: :blank_to_nil, headers: true, return_headers: false,
                header_converters: :symbol }
    CSV.open(path, options) do |csv|
      csv.to_a.map(&:to_hash)
    end
  end

  def original_format_to_dinosaur(dino)
    dino[:weight] = dino[:weight_in_lbs]
    Dinosaur.new(dino)
  end

  def p_b_africa_format_to_dinosaur(dino)
    dino[:continent] = "Africa"
    dino[:name] = dino[:genus]
    if dino.key?(:carnivore)
      dino[:diet] = dino[:carnivore] == "Yes" ? "Carnivore" : "Herbivore"
    end
    Dinosaur.new(dino)
  end
end
