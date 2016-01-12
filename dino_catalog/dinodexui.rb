require_relative "dinosaur_catalog"

class DinodexUI
  attr_accessor :running
  attr_accessor :catalog

  @current_menu = 0
  @menu_text = [
    "0) Quit 1) Show bipeds 2) Show carnivores 3) Search period 4) Size menu",
    "B) Go back 0) Quit | Enter a search term:",
    "B) Go back 0) Quit 1) Show large dinosaurs 2) Show small dinosaurs",
  ]

  def self.start(attr = {})
    @catalog = DinosaurCatalog.new(catalogs: attr[:catalogs])
    run
  end

  def self.run
    @running = true
    system "clear" || "cls"
    while @running
      show_menu_options
      handle_user_input(gets.chomp.downcase)
      puts
    end
  end

  def self.show_menu_options
    puts @menu_text[@current_menu]
  end

  def self.handle_user_input(user_input)
    quit if user_input == "0"

    handle_main_menu_input(user_input) if @current_menu == 0
    handle_search_input(user_input) if @current_menu == 1
    handle_size_input(user_input) if @current_menu == 2
  end

  def self.handle_main_menu_input(user_input)
    puts @catalog.find_bipeds if user_input == "1"
    puts @catalog.find_carnivores if user_input == "2"
    switch_to_period_menu if user_input == "3"
    switch_to_size_menu if user_input == "4"
  end

  def self.switch_to_period_menu
    @current_menu = 1
  end

  def self.switch_to_size_menu
    @current_menu = 2
  end

  def self.handle_search_input(user_input)
    @current_menu = 0 if user_input == "b"
  end

  def self.handle_size_input(user_input)
    @catalog.find_large_dinosaurs if user_input == "1"
    @catalog.find_small_dinosaurs if user_input == "2"
    @current_menu = 0 if user_input == "b"
  end

  def self.quit
    @running = false
  end
end
