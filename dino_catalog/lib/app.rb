require 'pry'
require 'active_support/core_ext'

require_relative 'csv_modifier'
require_relative 'filters'

class App
  include CsvModifier
  include Filters

  CARNIVORES = ['Carnivore', 'Insectivore', 'Piscivore']

  USER_PROMPT = <<-HEREDOC.strip_heredoc

    What would you like to do?\n
    You can enter a phrase that includes the keywords you want to filter the dinosaur catalog by.\n
    For example:\n
      Carnivores Big Traissic Bipeds\n
    Which will return all dinosaurs that meet the four criteria.\n
    Otherwise, to exit this program, enter 'quit'.\n
    HEREDOC

  SEARCH_REGEX = {
    biped_regex: /biped/,
    carnivore_regex: /carnivore|insectivore|piscivore/,
    period_regex: /cretaceous|permian|jurassic|oxfordian|albian|triassic/,
    size_regex: /big|small/
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
    Catalog.new(filepath)
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
      search_terms = get_user_search_terms(user_input)
      action = do_action(formatted_action_arguments)
    end
  end

  def get_user_search_terms(phrase)
    search_terms = []
    SEARCH_REGEX.each do |term, regex|
      matches = phrase.scan(regex)
      search_terms.push(matches) unless matches.empty?
    end
    search_terms.flatten
  end

  def do_action(action)
    case action[0]
    when 'bipeds'
      list_bipeds
    when 'carnivores'
      list_carnivores
    when 'period'
      list_period(action[1])
    when 'big'
      list_size(action[0])
    when 'small'
      list_size(action[0])
    when 'back'
      return :back
    when 'quit'
      puts "\n\nExiting.\n\n"
      exit!
    else
      "I don't understand. Please enter a valid input."
    end
  end

end
