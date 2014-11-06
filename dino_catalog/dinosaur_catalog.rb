require 'json'
require_relative 'dinosaur.rb'
require_relative 'dinosaur_parser.rb'

class DinosaurCatalog
  FILTERS               = [:biped, :quadruped, :carnivore,
                           :herbivore, :large, :small, :period, :continent]

  TEXT_FILTERS          = [:period, :continent]
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
    @filters << [filter, args] if FILTERS.include?(filter)
  end

  def display
    pre_output
    print_filtered_dinosaurs
  end

  def to_a
    pre_output
    convert_to_array
  end

  def save_json(filename = DEFAULT_JSON_FILENAME)
    File.open(filename, "w") do |f|
      f.write(to_a.to_json)
    end
  end

  private

  def init_filtered_dinosaurs
    @filtered_dinosaurs = @dinosaurs.clone
  end

  def reset_filtered_dinosaurs
    @filtered_dinosaurs = nil
  end

  def print_filtered_dinosaurs
    @filtered_dinosaurs.each(&:display)
    puts "Displaying #{@filtered_dinosaurs.length} from #{@dinosaurs.length}"
  end

  def execute_filter(filter, args)
    filter_method = "#{filter}?".to_sym

    @filtered_dinosaurs.select! do |dinosaur|
      dinosaur.send(filter_method, *args)
    end
  end

  def execute_all_filters
    @filters.each do |f|
      execute_filter(*f)
    end
  end

  def pre_output
    init_filtered_dinosaurs
    execute_all_filters
  end

  def convert_to_array
    @filtered_dinosaurs.each_with_object([]) { |e, a| a << e.to_hash }
  end
end
