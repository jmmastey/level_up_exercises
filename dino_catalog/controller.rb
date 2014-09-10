require "json"
require_relative "dino_collection"

class Controller
  attr_accessor :all_the_dinos

  ACTION_MAP = {
    "all"       => :print_all_dinos,
    "params"    => :search_dinos,
    "add"       => :new_csv,
    "exit"      => :exit,
    "quit"      => :exit,
    "q"         => :exit,
    "examples"  => :print_examples,
    "else"      => :print_invalid_choice
  }

  def initialize
    @all_the_dinos = DinoCollection.new
    populate_directory
    welcome
  end

  def welcome
    print_welcome_message
    make_choices
  end

  def make_choices
    print_choice_menu
    choice = gets.chomp.downcase

    choice = "else" unless ACTION_MAP.has_key? choice

    self.send(ACTION_MAP[choice])

    make_choices
  end

  private

  def print_all_dinos
    all_the_dinos.print_all
  end

  def print_invalid_choice
    puts "\nWhoops! Your entry is not one of the options :(".colorize(:red)
  end

  def search_dinos
    puts "Please enter a hash of search params:"
    puts "example: { 'period' : 'cretaceous', 'diet' : 'carnivore' }"

    filter_params = JSON.parse(gets.chomp)
    puts "\nSearch results:"
    puts filter_dinos(filter_params).map(&:to_s)
  end

  def filter_dinos(filter_params)
    filtered_dinos = all_the_dinos.dinos

    filter_params.each do |key, val|
      filtered_dinos.select! { |d| d.send(key) == val }
    end

    filtered_dinos
  end

  def new_csv
    puts "Please enter the filename:"
    filename = gets.chomp
    all_the_dinos.add_from_csv(filename)
  end

  def populate_directory
    all_the_dinos.add_from_csv("dinodex.csv")
    all_the_dinos.add_from_csv("african_dinosaur_export.csv")
  end

  def print_welcome_message
    puts "\nWelome to the Dino Directory!!!!!".colorize(:green)
  end

  def print_choice_menu
    puts "----------------------------------------------------------"
    puts "\nWhat would you like to do?".colorize(:light_cyan)
    puts "  - Enter 'all' to print all dinos"
    puts "  - Enter 'params' to print dinos with specific parameters"
    puts "  - Enter 'add' to add new dinos via CSV"
    puts "  - Enter 'examples' for preset filters"
    puts "  - Enter 'exit' to exit"
  end

  def print_examples
    all_the_dinos.print_bipeds
    all_the_dinos.print_meat_eaters
    all_the_dinos.print_from_period("permian")
    all_the_dinos.print_from_period("jurassic")
    all_the_dinos.print_weighs_more_than(2000)
    all_the_dinos.print_weighs_more_than(1999)
  end
end

Controller.new

