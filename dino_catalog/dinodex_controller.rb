require 'colorize'
require './dinosaur_catalog'
require './tasks'

class DinodexController
  def initialize(catalog)
    @catalog = catalog

    @tasks = Tasks.new
    @tasks.add("fields"   , @catalog.method(:display_fields),         "Display Fields")
    @tasks.add("names"    , @catalog.method(:display_names),          "Display Names")
    @tasks.add("bipeds"   , @catalog.method(:display_bipeds),         "Display Bipeds")
    @tasks.add("carnis"   , @catalog.method(:display_carnivores),     "Display Carnivores")
    @tasks.add("organize" , @catalog.method(:organize_by_period),     "Organize By Period")
    @tasks.add("heavy"    , @catalog.method(:display_heavy_weights),  "Display Heavyweights")
    @tasks.add("welter"   , @catalog.method(:display_welter_weights), "Display Welterweights")
    @tasks.add("lookup"   , @catalog.method(:display_dinosaur),       "Lookup Dinosaur [e.g. lookup Afrovenator]")
    @tasks.add("search"   , @catalog.method(:search_dinosaur),        "Search Dinosaur [e.g. search walking=Biped diet=Carnivore ... ]")
    @tasks.add("export"   , @catalog.method(:export_to_JSON),         "Export JSON [e.g. export dinos.json]")
    @tasks.add("menu"     , method(:display_menu),                    "Menu")
    @tasks.add("quit"     , method(:quit),                            "Quit")
  end

  def quit
    puts "Goodbye!"
    exit
  end

  def display_menu
    puts "\n" + @tasks.menu
  end

  def get_user_choice
    print "Enter Choice > ".yellow;
    user_choice = $stdin.gets.chomp
    puts
    user_choice
  end

  def run
    display_menu()

    while true
      user_choice = get_user_choice
      @tasks.fire(user_choice)
    end
  end
end
