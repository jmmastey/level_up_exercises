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

  def to_s
    execute_all_filters
    print_filtered_dinosaurs
  end

  def to_a
    execute_all_filters
    convert_to_array
  end

  def to_json
    to_a.to_json
  end

  def save_json(filename = DEFAULT_JSON_FILENAME)
    File.open(filename, "w") do |f|
      f.write(to_json)
    end
  end

  private

  def reset_filtered_dinosaurs
    @filtered_dinosaurs = @dinosaurs.clone
  end

  def print_filtered_dinosaurs
    @filtered_dinosaurs.each(&:to_s)
    puts "Displaying #{@filtered_dinosaurs.length} from #{@dinosaurs.length}"
  end

  def execute_filter(filter, args)
    filter_method = "#{filter}?".to_sym

    @filtered_dinosaurs.select! do |dinosaur|
      dinosaur.send(filter_method, *args)
    end
  end

  def execute_all_filters
    reset_filtered_dinosaurs

    @filters.each do |f|
      execute_filter(*f)
    end
  end

  def convert_to_array
    @filtered_dinosaurs.each_with_object([]) do
      |dinosaur, dinosaurs| dinosaurs << dinosaur.to_hash
    end
  end
end
