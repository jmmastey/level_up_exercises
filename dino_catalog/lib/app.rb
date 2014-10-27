require 'pry'
require 'active_support/core_ext'

require_relative 'csv_modifier'

class App
  include CsvModifier
  include Filters

  USER_PROMPT = <<-HEREDOC.strip_heredoc

    What would you like to do?\n
    You can enter a phrase that includes the keywords you want to filter the dinosaur catalog by.\n
    For example:\n
      Carnivores Big Triassic Bipeds\n
    Which will return all dinosaurs that meet the four criteria.\n
    Otherwise, to exit this program, enter 'quit'.\n
    HEREDOC

  SEARCH_REGEX = {
    bipeds: /biped/,
    carnivores: /carnivore|insectivore|piscivore/,
    periods: /cretaceous|permian|jurassic|oxfordian|albian|triassic/,
    sizes: /big|small/
  }

  def initialize(name)
    @app_name = name
  end

  def normalize_csv_file(csv_file)
    normalize_csv_headers(csv_file)
  end

  def create_dinosaur_entry(name, attributes)
    Dinosaur.new(name, attributes)
  end

  def create_catalog(filepath)
    @catalog = Catalog.new(filepath)
  end

  def launch!(csv_filename)
    normalize_csv_file(csv_filename)
    @catalog = create_catalog("normalized_csv_file.csv")
    obtain_user_filters
  end

  def obtain_user_filters
    action = nil
    until action == :back
      print USER_PROMPT
      print '> '
      user_input = gets.chomp.downcase
      exit! if user_input == 'exit'
      search_terms = get_user_search_terms(user_input)
      @filtered_dinosaurs = filter_results(@catalog, search_terms)
      puts @filtered_dinosaurs
    end
  end

  def user_actions
    until action == :exit
      print 'The following dinosaurs meet your search criteria:'
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
    filtered_dinosaur_listings = []
    filters.each do |search_type, criteria|
      filter_function = "filter_#{search_type}".to_sym
      filtered_dinosaur_listings << catalog.send(filter_function, criteria)
    end
    filtered_dinosaur_listings.flatten.uniq
  end

end
