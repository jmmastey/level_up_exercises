require 'json'
require_relative 'dinosaur.rb'
require_relative 'dinosaur_parser.rb'

class DinosaurCatalog
  FILTERS = [:biped, :carnivore, :continent, :large, :period]
  DEFAULT_JSON_FILENAME = "dinosaurs.json"

  def initialize
    @dinosaurs          = []
    @filtered_dinosaurs = []
    @filters            = []
  end

  def add(dinosaurs)
    @dinosaurs.concat(dinosaurs)
  end

  def add_filter(filter, *args)
    @filters << { filter: filter, args: args } if FILTERS.include?(filter)
  end

  def init_filtered_dinosaurs
    @filtered_dinosaurs = @dinosaurs.clone
  end

  def execute_all_filters
    @filters.each do |f|
      send f[:filter], *f[:args]
    end
  end

  def print_filtered_dinosaurs
    print_separator

    @filtered_dinosaurs.each do |dino|
      dino.display
      print_separator
    end

    puts "Displaying #{@filtered_dinosaurs.length} from #{@dinosaurs.length}"
  end

  def reset_filtered_dinosaurs
    @filtered_dinosaurs = nil
  end

  def pre_dump
    init_filtered_dinosaurs
    execute_all_filters
  end

  def display
    pre_dump
    print_filtered_dinosaurs
  end

  def to_a
    pre_dump
    convert_to_array
  end

  def save_json(filename = nil)
    filename ||= DEFAULT_JSON_FILENAME

    File.open(filename, "w") do |f|
      f.write(to_a.to_json)
    end
  end

  def biped(condition = true)
    filter_common { |dino| dino.biped? == condition }
  end

  def carnivores(condition = true)
    filter_common { |dino| dino.carnivore? == condition }
  end

  def large(condition = true)
    filter_common { |dino| dino.big_dinosaur? == condition }
  end

  def continent(continent)
    filter_common do |dino|
      regexp = "^#{continent}"
      dino.continent =~ Regexp.new(regexp, true)
    end
  end

  def period(period)
    filter_common do |dino|
      regexp = "^#{period}"
      dino.period =~ Regexp.new(regexp, true)
    end
  end

  def filter_common(&block)
    @filtered_dinosaurs.select!(&block)
  end

  def print_separator
    puts '-' * 90
  end

  def convert_to_array
    @filtered_dinosaurs.each_with_object([]) { |e, a| a << e.to_hash }
  end

  private :init_filtered_dinosaurs, :execute_all_filters,
    :print_filtered_dinosaurs, :reset_filtered_dinosaurs, :biped,
    :carnivores, :large, :continent, :period,
    :filter_common, :pre_dump, :to_a
end
