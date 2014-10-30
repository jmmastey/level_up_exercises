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
require 'user_processing'

class App
  include BuildCsv
  include CsvModifier
  include Filters
  include Display
  include JsonExport
  include UserProcessing

  def initialize(name)
    @app_name = name
  end

  def launch!(csv_filename=nil, user_hash_input=nil)
    @csv_filename = csv_filename
    normalize_csv_file(csv_filename)
    @catalog = create_catalog("normalized_csv_file.csv")
    obtain_user_filters
  end

  def create_catalog(filepath)
    @catalog = Catalog.new(filepath)
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

  # def direct_user_input_search(search_terms)
  #   @filtered_dinosaurs = nil
  #   @filtered_dinosaurs = filter_results(@catalog, search_terms)
  #   puts "\nYour search resulted in #{@filtered_dinosaurs.size} dinosaurs:"
  #   print_search_summary(@filtered_dinosaurs)
  #   user_processing(@filtered_dinosaurs)
  # end
  # User hash input to be implemented in a later iteration

end
