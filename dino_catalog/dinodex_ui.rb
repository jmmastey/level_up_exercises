class DinoDexUI
  require_relative 'dinodex'

  FILTER_OPTIONS = {
    period: %w(Cretaceous Jurassic Triassic Permian),
    continent: %w(North\ America South\ America Europe Africa Asia),
    diet: %w(Herbivore Carnivore Insectivore Piscivore),
    size: %w(Small Large),
    walking: %w(Biped Quadruped),
  }.freeze

  def initialize(dino_list)
    @dex = DinoDex.new(dino_list)
    @search_results = []
    @search_hash = {}
  end

  def run
    command = ''
    while command != 'q'
      puts main_menu_text
      printf 'Enter a command: '
      command = gets.chomp
      handle_menu_command(command)
    end
  end

  private

  def main_menu_text
    puts "\e[H\e[2J"
    puts "search filters = #{@search_hash}"
    print_number_of_results
    %(
--Menu-------------------
  -(n)ame search
  -(a)ll dinosaurs
  -(f)ilter dinosaurs
  -(c)lear filters
  -(p)rint search results
  -(q)uit
)
  end

  def handle_menu_command(command)
    case command
      when 'q' then puts 'Goodbye!'
      when 'a' then all_dinosaurs
      when 'n' then find_by_name
      when 'c' then clear_filters
      when 'f' then filter_menu
      when 'p' then print_search_results
      else
        puts 'Sorry, invalid command'
    end
  end

  def filter_menu
    puts "\e[H\e[2J"
    puts '--Filters----------------'
    FILTER_OPTIONS.values.each do |value|
      puts value.inspect
    end
    printf 'Enter one or more filters, separated by commas: '
    filter_dinosaurs(gets.chomp)
  end

  def filter_dinosaurs(filters)
    add_filters_to_hash(filters)
    if @search_hash.empty?
      puts 'Invalid filter(s)'
    else
      @search_results ||= @dex.all_dinosaurs
      @search_results = @dex.filter_by_hash(@search_hash)
    end
  end

  def add_filters_to_hash(filters)
    parse_filters(filters).each { |filter| add_filter(filter) }
  end

  def add_filter(filter)
    FILTER_OPTIONS.each do |attribute, values|
      if values.map(&:downcase).include?(filter)
        @search_hash[attribute] = filter
      end
    end
  end

  def parse_filters(filters)
    filters.split(',').map(&:strip).map(&:downcase)
  end

  def clear_filters
    @search_results = []
    @search_hash = {}
  end

  def all_dinosaurs
    @search_results = @dex.all_dinosaurs
  end

  def find_by_name
    puts "\e[H\e[2J"
    printf 'Enter dinosaur name: '
    @search_results = @dex.find_by_name(gets.chomp)
  end

  def print_number_of_results
    number_of_results = @search_results.size
    puts "#{number_of_results} "\
         "#{number_of_results == 1 ? 'dinosaur' : 'dinosaurs'} selected."
  end

  def print_search_results
    output = if @search_results.empty?
               'Search results empty'
             else
               @search_results.map(&:to_s).join("\n")
             end
    IO.popen('less', 'w') { |f| f.puts output }
  end
end
