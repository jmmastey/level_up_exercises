require 'json'
require_relative 'dinosaur.rb'
require_relative 'dinosaur_parser.rb'

class DinosaurCatalog
  FILTER_METHODS = {
    :biped => :filter_bipeds,
    :carnivore => :filter_carnivores,
    :continent => :filter_continent,
    :large => :filter_large,
    :period => :filter_period,
  }

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
    if FILTER_METHODS.key? filter
      @filters << {
        :filter => FILTER_METHODS[filter],
        :args => args,
      }
    end

    self
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

  def filter_bipeds(condition = true)
    filter_common { |dino| dino.biped? == condition }
  end

  def filter_carnivores(condition = true)
    filter_common { |dino| dino.carnivore? == condition }
  end

  def filter_large(condition = true)
    filter_common { |dino| dino.big_dinosaur? == condition }
  end

  def filter_continent(continent)
    filter_common do |dino|
      regexp = "^#{continent}"
      dino.continent =~ Regexp.new(regexp, true)
    end
  end

  def filter_period(period)
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
    @filtered_dinosaurs.inject([]) { |a, e| a << e.to_hash; a}
  end

  private :init_filtered_dinosaurs, :execute_all_filters,
    :print_filtered_dinosaurs, :reset_filtered_dinosaurs, :filter_bipeds,
    :filter_carnivores, :filter_large, :filter_continent,
    :filter_common, :pre_dump, :to_a
end
