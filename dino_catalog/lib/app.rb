require 'pry'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector/inflections'
require 'display'
require 'json_export'
require 'option_parser'
require 'build_csv'
require 'csv_modifier'
require 'user_prompts'

class App
  include BuildCsv
  include CsvModifier
  include Filters
  include Display
  include JsonExport

  SEARCH_REGEX = {
    bipeds: /biped/,
    carnivores: /carnivore|insectivore|piscivore/,
    periods: /cretaceous|permian|jurassic|oxfordian|albian|triassic/,
    sizes: /big|small/
  }

  def initialize(name)
    @app_name = name
  end

  def create_dinosaur_entry(name, attributes)
    Dinosaur.new(name, attributes)
  end

  def create_catalog(filepath)
    @catalog = Catalog.new(filepath)
  end

  def launch!(csv_filename=nil, user_hash_input=nil)
    @csv_filename = csv_filename
    normalize_csv_file(csv_filename)
    @catalog = create_catalog("normalized_csv_file.csv")
    obtain_user_filters
  end

  def obtain_user_filters
    @filtered_dinosaurs = nil
    print UserPrompts::USER_SEARCH_PROMPT
    print '> '
    user_input = gets.chomp.downcase
    exit! if user_input == 'exit' || user_input == 'quit'
    search_terms = get_user_search_terms(user_input)
    @filtered_dinosaurs = filter_results(@catalog, search_terms)
    puts "\nYour search resulted in #{@filtered_dinosaurs.size} dinosaurs:"
    print_search_summary(@filtered_dinosaurs)
    user_processing(@filtered_dinosaurs)
  end

  # def direct_user_input_search(search_terms)
  #   @filtered_dinosaurs = nil
  #   @filtered_dinosaurs = filter_results(@catalog, search_terms)
  #   puts "\nYour search resulted in #{@filtered_dinosaurs.size} dinosaurs:"
  #   print_search_summary(@filtered_dinosaurs)
  #   user_processing(@filtered_dinosaurs)
  # end
  # User hash input to be implemented in a later iteration

  def user_processing(dinosaurs)
    print UserPrompts::USER_PROCESSING_PROMPT
    print '> '
    user_input = gets.chomp.downcase
    exit! if user_input == 'exit' || user_input == 'quit'
    user_actions(user_input)
  end

  def user_actions(input)
    exit! if input == 'exit' || input == 'quit'
    if input == 'print'
      print_dinosaur_set(@filtered_dinosaurs)
      user_processing(@filtered_dinosaurs)
    elsif input == 'search'
      launch!(@csv_filename)
    elsif input == 'json'
      convert_to_json(@filtered_dinosaurs)
      puts "\nYour JSON file has been saved as json_export.json in the main directory."
      user_processing(@filtered_dinosaurs)
    else
      print_dinosaur_instance(@filtered_dinosaurs, input)
      user_processing(@filtered_dinosaurs)
    end
  end

  def get_user_search_terms(phrase)
    search_terms = {}
    SEARCH_REGEX.each do |term, regex|
      search_terms[term] = phrase.scan(regex) unless phrase.scan(regex).empty? #  use inject?
    end
    search_terms
  end

  def filter_results(catalog, filters)
    filtered_dinosaur_listings = catalog.dinosaurs
    filters.each do |search_type, criteria|
      filter_function = "filter_#{search_type}".to_sym
      filtered_dinosaur_listings = Catalog.from_array(filtered_dinosaur_listings).send(filter_function, criteria)
    end
    filtered_dinosaur_listings
  end

  def print_search_summary(search_results)
    puts "\n"
    search_results.each { |dinosaur| puts "#{dinosaur.name}"}
    puts "\n"
  end

end
