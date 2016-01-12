require_relative "dinosaur_catalog"

class DinodexUI
  attr_accessor :running
  attr_accessor :catalog

  @current_menu = 0

  @menu_text = [
    "1) Show bipeds 2) Show carnivores 3) Period menu 4) Size menu 5) Search",
    "",
    "1) Show large dinosaurs 2) Show small dinosaurs",
    "Search with key:value (eg: diet:herbivore)\nChain searches with comma.\n",
  ]

  def self.start(attr = {})
    @catalog = DinosaurCatalog.new(catalogs: attr[:catalogs])
    @menu_text[1] = period_options
    run
  end

  def self.run
    @running = true
    system "clear" || "cls"
    show_banner
    while @running
      show_menu_options
      handle_user_input(gets.chomp.downcase)
    end
  end

  def self.show_banner
    File.open('dinobanner.txt', 'r') do |f|
      puts f.read
    end
  end

  def self.show_menu_options
    puts
    puts "J) To json B) Back Q) Quit"
    puts @menu_text[@current_menu]
    puts "\nKeys: #{@catalog.dinodex_keys.join(',')}" if @current_menu == 3
    puts
  end

  def self.handle_user_input(user_input)
    system "clear" || "cls"

    if user_input == "b" && @current_menu > 0
      @current_menu = 0
    elsif user_input == "q"
      quit
    elsif user_input == "j"
      @catalog.export_to_json
      puts "Saved catalog to #{@catalog.json_file_name}"
    else
      case @current_menu
        when 0
          handle_main_menu_input(user_input)
        when 1
          handle_period_input(user_input)
        when 2
          handle_size_input(user_input)
        when 3
          handle_search_input(user_input)
      end
    end
  end

  def self.handle_main_menu_input(user_input)
    show_dinosaur_facts @catalog.find_bipeds if user_input == "1"
    show_dinosaur_facts @catalog.find_carnivores if user_input == "2"
    @current_menu = 1 if user_input == "3"
    @current_menu = 2 if user_input == "4"
    @current_menu = 3 if user_input == "5"
  end

  def self.handle_period_input(user_input)
    period = @catalog.dinodex_periods[user_input.to_i - 1]
    show_dinosaur_facts @catalog.find_dinos(:period, period.downcase)
  end

  def self.handle_size_input(user_input)
    show_dinosaur_facts @catalog.find_large_dinosaurs if user_input == "1"
    show_dinosaur_facts @catalog.find_small_dinosaurs if user_input == "2"
  end

  def self.handle_search_input(user_input)
    index = nil
    user_input.split(',').each do |search|
      facet = search.split(':')
      index = @catalog.find_dinos(facet[0].to_sym, facet[1], index)
    end
    show_dinosaur_facts index
  end

  def self.period_options
    option = 1
    options = ""
    @catalog.dinodex_periods.each do |period|
      options += "#{option}) #{period} "
      option += 1
    end
    options
  end

  def self.show_dinosaur_facts(results)
    results.each do |dino|
      puts "\nName: #{dino[:name]}"
      puts "Period: #{dino[:period]}"
      puts "Walking: #{dino[:walking]}"
      puts "Continent: #{dino[:continent]}." if dino[:continent]
      puts "Diet: #{dino[:diet]}" if dino[:diet]
      puts "Approx weight: #{dino[:weight]}lbs." if dino[:weight]
      puts "Facts: #{dino[:description]}" if dino[:description]
    end
  end

  def self.quit
    @running = false
  end
end
